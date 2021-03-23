local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G

function S:LootFrame()
    if not self:CheckDB("loot") then
        return
    end
    
    F.SetFontOutline(_G.BonusRollFrame.PromptFrame.InfoFrame.Cost)
    F.SetFontOutline(_G.BonusRollFrame.PromptFrame.InfoFrame.Label)
    
    self:CreateBackdropShadow(_G.BonusRollFrame)
    self:CreateBackdropShadow(_G.BonusRollLootWonFrame)
    self:CreateBackdropShadow(_G.BonusRollMoneyWonFrame)
end

S:AddCallback("LootFrame")
