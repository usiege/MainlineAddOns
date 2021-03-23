local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")
local ES = E:GetModule("Skins")
local MF = W:GetModule("MoveFrames")

local _G = _G
local pairs = pairs
local CreateFrame = CreateFrame

do
    local DeleteRegions = {
        "Center",
        "BottomEdge",
        "LeftEdge",
        "RightEdge",
        "TopEdge",
        "BottomLeftCorner",
        "BottomRightCorner",
        "TopLeftCorner",
        "TopRightCorner"
    }

    function S:TinyInspect_SkinListPanel(unit, parent, ilevel, maxLevel)
        if not parent or not parent.inspectFrame then
            return
        end

        local frame = parent.inspectFrame
        frame:ClearAllPoints()
        frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 5, 0)

        if parent.inspectFrameHolder then
            parent.inspectFrameHolder:Show()
            return
        end

        for _, regionKey in pairs(DeleteRegions) do
            if frame[regionKey] then
                frame[regionKey]:Kill()
            end
        end

        frame.closeButton:ClearAllPoints()
        frame.closeButton:SetPoint("BOTTOMLEFT", 3, 3)

        if frame.specicon then
            frame.specicon:SetMask(nil)
            frame.specicon:Size(35)
            frame.specicon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        end

        if frame.spectext then
            F.SetFontOutline(frame.spectext, E.db.general.font)
        end

        for i = 1, 20 do
            if frame["item" .. i] then
                F.SetFontOutline(frame["item" .. i].itemString, E.db.general.font)
                F.SetFontOutline(frame["item" .. i].levelString, "Montserrat")
            end
        end

        local inspectFrameHolder = CreateFrame("Frame", nil, parent)
        inspectFrameHolder:Point("TOPLEFT", frame, "TOPLEFT", 0, -1)
        inspectFrameHolder:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 1)
        inspectFrameHolder:CreateBackdrop("Transparent")
        inspectFrameHolder.backdrop:SetFrameLevel(frame:GetFrameLevel())
        inspectFrameHolder.backdrop:SetFrameStrata(frame:GetFrameStrata())
        self:CreateShadow(inspectFrameHolder, 5)

        self:SecureHookScript(
            frame.closeButton,
            "OnClick",
            function()
                inspectFrameHolder:Hide()
            end
        )

        self:SecureHookScript(
            parent,
            "OnHide",
            function()
                inspectFrameHolder:Hide()
            end
        )

        if MF and MF.db and MF.db.moveBlizzardFrames then
            MF:HandleFrame(inspectFrameHolder, parent.MoveFrame or parent)
            frame.MoveFrame = inspectFrameHolder.MoveFrame
        end

        inspectFrameHolder:Show()
        parent.inspectFrameHolder = inspectFrameHolder
        frame:SetParent(inspectFrameHolder)
    end
end

do
    local DeleteBorders = {
        "Bg",
        "BorderBottomLeft",
        "BorderBottomMiddle",
        "BorderBottomRight",
        "BorderLeftMiddle",
        "BorderRightMiddle",
        "BorderTopMiddle",
        "BorderTopLeft",
        "BorderTopRight"
    }

    function S:TinyInspect_SkinStatsPanel(frame, unit)
        local statsFrame = frame.statsFrame
        if not statsFrame then
            return
        end

        if frame.statsFrameHolder then
            frame.statsFrameHolder:Show()
            return
        end

        for _, regionKey in pairs(DeleteBorders) do
            if statsFrame[regionKey] then
                statsFrame[regionKey]:Kill()
            end
        end

        for i = 1, 20 do
            F.SetFontOutline(statsFrame["stat" .. i].Label, E.db.general.font)
            F.SetFontOutline(statsFrame["stat" .. i].Value, E.db.general.font)
            F.SetFontOutline(statsFrame["stat" .. i].PlayerValue, E.db.general.font)
        end

        for _, region in pairs {statsFrame:GetRegions()} do
            if region:GetTexture() == "Interface\\Tooltips\\UI-Tooltip-Background" then
                region:ClearAllPoints()
                region:Point("TOPLEFT", statsFrame, "TOPRIGHT", -58, -1)
                region:Point("BOTTOMRIGHT", statsFrame, "BOTTOMRIGHT", 0, 1)
            end
        end

        local statsFrameHolder = CreateFrame("Frame", nil, frame)
        statsFrameHolder:Point("TOPLEFT", statsFrame, "TOPLEFT", 0, -1)
        statsFrameHolder:Point("BOTTOMRIGHT", statsFrame, "BOTTOMRIGHT", 0, 1)
        statsFrameHolder:CreateBackdrop("Transparent")
        statsFrameHolder.backdrop:SetFrameLevel(statsFrame:GetFrameLevel())
        statsFrameHolder.backdrop:SetFrameStrata(statsFrame:GetFrameStrata())
        self:CreateShadow(statsFrameHolder, 5)

        local OldExpandButtonOnClick = frame.expandButton:GetScript("OnClick")
        frame.expandButton:SetScript(
            "OnClick",
            function(self)
                OldExpandButtonOnClick(self)
                if statsFrame:IsShown() then
                    statsFrameHolder:Show()
                else
                    statsFrameHolder:Hide()
                end
            end
        )

        statsFrame:SetScript(
            "OnHide",
            function(self)
                statsFrameHolder:Hide()
            end
        )

        if MF and MF.db and MF.db.moveBlizzardFrames then
            local parent = frame:GetParent()
            MF:HandleFrame(statsFrameHolder, parent.MoveFrame or parent)
        end

        statsFrameHolder:Show()
        frame.statsFrameHolder = statsFrameHolder
        statsFrame:SetParent(statsFrameHolder)

        self:SecureHook(
            statsFrame,
            "SetPoint",
            function(_, _, _, _, _, y)
                if y ~= 0 then
                    statsFrame:ClearAllPoints()
                    statsFrame:Point("TOPLEFT", statsFrame:GetParent(), "TOPRIGHT", 5, 0)
                end
            end
        )
    end
end

function S:TinyInspect()
    if not E.private.WT.skins.enable or not E.private.WT.skins.addons.tinyInspect then
        return
    end

    if _G.ShowInspectItemListFrame then
        self:SecureHook("ShowInspectItemListFrame", "TinyInspect_SkinListPanel")
    end

    if _G.ShowInspectItemStatsFrame then
        self:SecureHook("ShowInspectItemStatsFrame", "TinyInspect_SkinStatsPanel")
    end
end

S:AddCallbackForAddon("TinyInspect")
S:DisableAddOnSkin("TinyInspect")
