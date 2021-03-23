local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G

function S:Blizzard_GuildBankUI()
    if not self:CheckDB("gbank", "guildBank") then
        return
    end

    self:CreateShadow(_G.GuildBankFrame)

    for i = 1, 4 do
        self:ReskinTab(_G["GuildBankFrameTab" .. i])
    end

    for i = 1, 6 do
        self:CreateShadow(_G["GuildBankTab" .. i .. "Button"])
    end
end

S:AddCallbackForAddon("Blizzard_GuildBankUI")