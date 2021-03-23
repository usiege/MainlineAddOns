local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G

function S:Blizzard_Communities()
    if not self:CheckDB("communities") then
        return
    end

    if _G.CommunitiesFrame then
        local f = _G.CommunitiesFrame
        self:CreateBackdropShadow(f)
        self:CreateShadow(f.ChatTab)
        self:CreateShadow(f.RosterTab)
        self:CreateShadow(f.GuildBenefitsTab)
        self:CreateShadow(f.GuildInfoTab)
        self:CreateBackdropShadow(f.GuildMemberDetailFrame)
        self:CreateBackdropShadow(f.ClubFinderInvitationFrame)
        if _G.CommunitiesGuildLogFrame then
            self:CreateBackdropShadow(_G.CommunitiesGuildLogFrame)
        end
    end

    -- 搜寻社群
    if _G.ClubFinderCommunityAndGuildFinderFrame then
        local f = _G.ClubFinderCommunityAndGuildFinderFrame
        if f.ClubFinderPendingTab then
            self:CreateShadow(f.ClubFinderPendingTab)
        end
        if f.ClubFinderSearchTab then
            self:CreateShadow(f.ClubFinderSearchTab)
        end
        if f.RequestToJoinFrame then
            self:CreateBackdropShadow(f.RequestToJoinFrame)
        end
    end

    -- 搜寻公会
    if _G.ClubFinderCommunityAndGuildFinderFrame then
        local f = _G.ClubFinderGuildFinderFrame
        if f.ClubFinderPendingTab then
            self:CreateShadow(f.ClubFinderPendingTab)
        end
        if f.ClubFinderSearchTab then
            self:CreateShadow(f.ClubFinderSearchTab)
        end
        if f.RequestToJoinFrame then
            self:CreateBackdropShadow(f.RequestToJoinFrame)
        end
    end

    -- 公会招募
    self:CreateBackdropShadow(_G.CommunitiesFrame.RecruitmentDialog)
end

S:AddCallbackForAddon("Blizzard_Communities")
