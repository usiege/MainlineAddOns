local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G

function S:Blizzard_ChallengesUI()
    if not self:CheckDB("lfg", "challenges") then
        return
    end

    self:CreateBackdropShadow(_G.ChallengesKeystoneFrame)
end

S:AddCallbackForAddon("Blizzard_ChallengesUI")
