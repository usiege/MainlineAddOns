local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G
local InCombatLockdown = InCombatLockdown

function S:ElvUI_SkinOptionsUI()
    if not InCombatLockdown() then
        self:CreateShadow(E:Config_GetWindow())
    end
end

function S:ElvUI_SkinInstall()
    if not InCombatLockdown() then
        self:CreateShadow(_G.ElvUIInstallFrame)
    end
end

function S:ElvUI_SkinMoverPopup()
    if not _G.ElvUIMoverPopupWindow then
        return
    end

    self:CreateShadow(_G.ElvUIMoverPopupWindow)
    self:CreateShadow(_G.ElvUIMoverPopupWindow.header)
end

function S:ElvUI_OptionsUI()
    if not (E.private.WT.skins.elvui.enable and E.private.WT.skins.elvui.option) then
        return
    end

    -- 设定
    self:SecureHook(E, "ToggleOptionsUI", "ElvUI_SkinOptionsUI")

    -- 安装
    if _G.ElvUIInstallFrame then
        self:CreateShadow(_G.ElvUIInstallFrame)
    else
        self:SecureHook(E, "Install", "ElvUI_SkinInstall")
    end

    -- 调整位置
    self:SecureHook(E, "ToggleMoveMode", "ElvUI_SkinMoverPopup")
end

S:AddCallback("ElvUI_OptionsUI")
