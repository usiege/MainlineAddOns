local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G
local pairs = pairs

function S:Blizzard_AdventureMap()
    if not self:CheckDB("AdventureMap", "adventureMap") then
        return
    end

    local AdventureMapQuestChoiceDialog = _G.AdventureMapQuestChoiceDialog
    local childFrame = AdventureMapQuestChoiceDialog.Details.Child

    S:CreateShadow(AdventureMapQuestChoiceDialog)
    AdventureMapQuestChoiceDialog.shadow:SetFrameStrata("LOW")

    F.SetFontOutline(childFrame.TitleHeader)
    F.SetFontOutline(childFrame.DescriptionText)
    F.SetFontOutline(childFrame.ObjectivesHeader)
    F.SetFontOutline(childFrame.ObjectivesText)
    F.SetFontOutline(AdventureMapQuestChoiceDialog.RewardsHeader)
end

S:AddCallbackForAddon("Blizzard_AdventureMap")
