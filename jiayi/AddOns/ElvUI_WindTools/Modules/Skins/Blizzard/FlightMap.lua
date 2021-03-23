local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G
local pairs = pairs

function S:Blizzard_FlightMap()
    if not self:CheckDB("taxi", "flightMap") then
        return
    end

    self:CreateBackdropShadow(_G.FlightMapFrame)
end

S:AddCallbackForAddon("Blizzard_FlightMap")