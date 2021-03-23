local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G

function S:Blizzard_AnimaDiversionUI()
    if not self:CheckDB("animaDiversion") then
        return
    end

    self:CreateBackdropShadow(_G.AnimaDiversionFrame)
end

S:AddCallbackForAddon("Blizzard_AnimaDiversionUI")
