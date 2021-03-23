BuildEnv(...)

Activity = Addon:NewClass('Activity', BaseActivity)

local AceSerializer = LibStub('AceSerializer-3.0')
local AceEvent = LibStub('AceEvent-3.0')

Activity:InitAttr{'ID', 'Age', 'IsDelisted', 'LeaderShort', 'NumMembers', 'IsApplication', 'IsApplicationFinished',
                  'IsAnyFriend', 'ApplicationStatus', 'PendingStatus', 'ApplicationDuration', 'ApplicationExpiration',
                  'DisplayType', 'MaxMembers', 'KilledBossCount'}

Activity._Objects = setmetatable({}, {
    __mode = 'v'
})

function Activity:Constructor(id)
    self.killedBosses = {}
    self:SetID(id)
    self:Update()
    self._Objects[id] = self
end

function Activity:Get(id)
    return self._Objects[id] or self:New(id)
end

function Activity:Update()
    local info = C_LFGList.GetSearchResultInfo(self:GetID())
    if not info then
        return
    end
    local id = info.searchResultID
    local activityId = info.activityID
    local title = info.name
    local comment = info.comment
    local voiceChat = info.voiceChat
    local iLvl = info.requiredItemLevel
    local honorLevel = info.requiredHonorLevel
    local age = info.age
    local numBNetFriends = info.numBNetFriends
    local numCharFriends = info.numCharFriends
    local numGuildMates = info.numGuildMates
    local isDelisted = info.isDelisted
    local leader = info.leaderName
    local numMembers = info.numMembers

    if not activityId then
        return false
    end
    if iLvl and iLvl < 0 then
        iLvl = 0
    end

    local name, shortName, category, group, iLevel, filters, minLevel, maxMembers, displayType =
        C_LFGList.GetActivityInfo(activityId)
    local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(id)

    if leader then
        self:SetLeaderShort(leader:match('^(.+)%-') or leader)
    end

    self:SetActivityID(activityId)
    self:SetGroupID(group)
    self:SetVoiceChat(voiceChat ~= '' and voiceChat or nil)
    self:SetItemLevel(iLvl)
    self:SetHonorLevel(honorLevel or 0)
    self:SetAge(age)
    self:SetIsDelisted(isDelisted)
    self:SetLeader(leader)
    self:SetNumMembers(numMembers)
    self:SetMaxMembers(maxMembers > 0 and maxMembers or 40)
    self:SetIsAnyFriend(numBNetFriends > 0 or numCharFriends > 0 or numGuildMates > 0)

    self:SetDisplayType(displayType)

    self:SetIsApplication(appStatus ~= 'none' or pendingStatus)
    self:SetIsApplicationFinished(LFGListUtil_IsStatusInactive(appStatus) or LFGListUtil_IsStatusInactive(pendingStatus))

    self:SetApplicationStatus(appStatus)
    self:SetPendingStatus(pendingStatus)
    self:SetApplicationDuration(appDuration)
    self:SetApplicationExpiration(GetTime() + appDuration)

    if not self:UpdateCustomData(comment, title) then
        return false
    end

    wipe(self.killedBosses)
    local customId = self:GetCustomID()
    if customId and CUSTOM_PROGRESSION_LIST[customId] then
        local savedInstance = self:GetSavedInstance()
        if savedInstance then
            for i, v in ipairs(CUSTOM_PROGRESSION_LIST[customId]) do
                self.killedBosses[v.name] = bit.band(savedInstance, bit.lshift(1, i - 1)) > 0 or nil
            end
        end
    else
        local completedEncounters = C_LFGList.GetSearchResultEncounterInfo(id)
        if completedEncounters then
            for i, v in ipairs(completedEncounters) do
                self.killedBosses[v] = true
            end
        end
        self:SetKilledBossCount(completedEncounters and #completedEncounters or 0)
    end

    self:UpdateSortValue()

    return true
end

function Activity:BaseSortHandler()
    if not self._baseSortValue then
        self:UpdateSortValue()
    end
    return self._baseSortValue
end

function Activity:GetStatusSortValue()
    if not self._statusSortValue then
        self:UpdateSortValue()
    end
    return self._statusSortValue
end

function Activity:GetTypeSortValue()
    if not self._typeSortValue then
        self._typeSortValue = format('%04x%04x', 0xFFFF -
                                  (ACTIVITY_ORDER.C[self:GetCustomID()] or ACTIVITY_ORDER.A[self:GetActivityID()] or
                                      ACTIVITY_ORDER.G[self:GetGroupID()] or 0), self:GetActivityID())
    end
    return self._typeSortValue
end

function Activity:UpdateSortValue()
    self._statusSortValue = self:IsApplication() and (self:IsApplicationFinished() and 1 or 0) or self:IsDelisted() and
                                9 or self:IsAnyFriend() and 2 or self:IsSelf() and 3 or self:IsInActivity() and 4 or 7

    self._baseSortValue = format('%d%04x%s%02x%02x%08x', self._statusSortValue, 0xFFFF - self:GetItemLevel(),
                              self:GetTypeSortValue(), self:GetLoot(), self:GetMode(), self:GetID())
end

function Activity:IsInActivity()
    return self:GetLeader() and IsInGroup(LE_PARTY_CATEGORY_HOME) and
               (UnitInRaid(self:GetLeader()) or UnitInParty(self:GetLeader()))
end

function Activity:IsSelf()
    return self:GetLeader() and UnitIsUnit(self:GetLeader(), 'player')
end

-- function Activity:Match(search, bossFilter, enableSpamWord, spamLength, enableSpamChar)
--     local summary, comment = self:GetSummary(), self:GetComment()
--     if summary then
--         summary = summary:lower()
--     end
--     if comment then
--         comment = comment:lower()
--     end

--     if enableSpamWord and (CheckSpamWord(summary) or CheckSpamWord(comment)) then
--         return false
--     end

--     if enableSpamChar then
--         return false
--     end

--     if search then
--         if summary and summary:find(search, 1, true) then
--             return true
--         elseif comment and comment:find(search, 1, true) then
--             return true
--         elseif self:GetLeader() and self:GetLeader():lower():find(search, 1, true) then
--             return true
--         else
--             return false
--         end
--     end

--     if spamLength and ((summary and strlenutf8(summary) > spamLength) or (comment and strlenutf8(comment) > spamLength)) then

--         return false
--     end

--     if bossFilter and next(bossFilter) then
--         for boss, flag in pairs(bossFilter) do
--             if flag then
--                 if self:IsBossKilled(boss) then
--                     return false
--                 end
--             else
--                 if not self:IsBossKilled(boss) then
--                     return false
--                 end
--             end
--         end
--     end
--     return true
-- end

local FILTERS = {
    ItemLevel = function(activity)
        return activity:GetItemLevel()
    end,
    BossKilled = function(activity)
        return activity:GetKilledBossCount()
    end,
    Age = function(activity)
        return activity:GetAge() / 60
    end,
    Members = function(activity)
        return activity:GetNumMembers()
    end
}

function Activity:Match(filters)
    for key, func in pairs(FILTERS) do
        local filter = filters[key]
        if filter and filter.enable then
            local value = func(self)
            if filter.min and filter.min ~= 0 and value < filter.min then
                return false
            end
            if filter.max and filter.max ~= 0 and value > filter.max then
                return false
            end
        end
    end
    -- 过滤条件:队长名
    local searchResultInfo = C_LFGList.GetSearchResultInfo(self:GetID())
    if (searchResultInfo ~= nil and searchResultInfo.leaderName ~= nil) then
        local leaderName = searchResultInfo.leaderName
        for k, v in ipairs(_G["MEETINGSTONE_UI_BLACKLISTEDLEADERS"]) do
            if (leaderName == v) then
                -- print("Filtered:Blacklisted Leader:"..v)
                return false
            end
        end
    end
    -- 反广告-暂时禁用
    if _G["MEETINGSTONE_UI_E_FILTERAD"] then
        local completedEncounters = self:GetKilledBossCount()
        local itemLevelRequired = self:GetItemLevel()
        local totalPlayers = self:GetNumMembers()
        local classInfo = {}
        local classCount = 0
        local fullName, shortName, categoryID, groupID, iLevel, filters, minLevel, maxPlayers, displayType, orderIndex, useHonorLevel, showQuickJoin = C_LFGList.GetActivityInfo(self:GetActivityID())
        
        if(fullName == nil) then
            return true
        end
        local age = self:GetAge()
        for i = 1, self:GetNumMembers() do
            local role, class, classLocalized = C_LFGList.GetSearchResultMemberInfo(self:GetID(), i)
            if not classInfo[class] and class then 
                classInfo[class] = {}
                classCount = classCount + 1
            end
        end
        -- 过滤条件:团本分类
        if(categoryID == 3) then
            -- 过滤条件1:团队>=15人且职业人数小于6
            if(totalPlayers >= 15) then
                if (classCount < 6) then
                    --print("Filtered:Less Classes")
                    return false
                end
            end
            if(totalPlayers > 9) then
                if (classCount < 4) then
                    --print("Filtered:Less Classes")
                    return false
                end
            end
            -- 过滤条件2:创建时间超过40分，且没有boss击杀
            if(age > 2400 and completedEncounters == 0) then
                --print("Filtered:Less Encounters")
                return false
            end
            -- 过滤条件3:装等低于160
            if(itemLevelRequired < 160) then
                --print("Filtered:Less Lv")
                return false
            end
        end
        -- 过滤条件:大米分类
        if(categoryID == 2 and shortName == CHALLENGES) then
            -- 过滤条件1:装等低于401
            if(itemLevelRequired < 160) then
                return false
            end
        end
    end
    return true
end

function Activity:IsLevelValid()
    local level = UnitLevel('player')
    return level >= self:GetMinLevel() and level <= self:GetMaxLevel()
end

function Activity:IsArenaActivity()
    return IsUsePvPRating(self:GetActivityID())
end

function Activity:IsPvPRatingValid()
    local pvpRating = GetPlayerPvPRating(self:GetActivityID())
    return pvpRating >= self:GetPvPRating()
end

function Activity:IsItemLevelValid()
    local equipLevel = GetPlayerItemLevel(self:IsUseHonorLevel())
    return equipLevel >= self:GetItemLevel()
end

function Activity:IsUnusable()
    return self:IsDelisted() or self:IsApplicationFinished()
end

function Activity:IsBossKilled(name)
    return self.killedBosses[name]
end
