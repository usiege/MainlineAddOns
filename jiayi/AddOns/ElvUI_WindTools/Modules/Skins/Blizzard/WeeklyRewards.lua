local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G

function S:Blizzard_WeeklyRewards()
    if not self:CheckDB("weeklyRewards") then
        return
    end

    self:CreateBackdropShadow(_G.WeeklyRewardsFrame)
end

S:AddCallbackForAddon("Blizzard_WeeklyRewards")
