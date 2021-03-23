local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")
local AB = E:GetModule("ActionBars")

local _G = _G
local pairs = pairs
local NUM_STANCE_SLOTS = NUM_STANCE_SLOTS
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function S:ElvUI_ActionBar_SkinBar(bar, type)
    if not (E.private.WT.skins.shadow and bar and bar.backdrop) then
        return
    end

    if E.private.WT.skins.elvui.actionBarsBackdrop then
        if bar.db.backdrop then
            if not bar.backdrop.shadow then
                self:CreateBackdropShadow(bar, true)
            end
            bar.backdrop.shadow:Show()
        else
            if bar.backdrop.shadow then
                bar.backdrop.shadow:Hide()
            end
        end
    end

    if E.private.WT.skins.elvui.actionBarsButton then
        if type == "PLAYER" then
            for i = 1, NUM_ACTIONBAR_BUTTONS do
                local button = bar.buttons[i]
                self:CreateBackdropShadow(button, true)
            end
        elseif type == "PET" then
            for i = 1, NUM_PET_ACTION_SLOTS do
                local button = _G["PetActionButton" .. i]
                self:CreateBackdropShadow(button, true)
            end
        elseif type == "STANCE" then
            for i = 1, NUM_STANCE_SLOTS do
                local button = _G["ElvUI_StanceBarButton" .. i]
                self:CreateBackdropShadow(button, true)
            end
        end
    end
end

function S:ElvUI_ActionBar_PositionAndSizeBar(actionBarModule, barName)
    local bar = actionBarModule.handledBars[barName]
    self:ElvUI_ActionBar_SkinBar(bar, "PLAYER")
end

function S:ElvUI_ActionBar_PositionAndSizeBarPet()
    self:ElvUI_ActionBar_SkinBar(_G.ElvUI_BarPet, "PET")
end

function S:ElvUI_ActionBar_PositionAndSizeBarShapeShift()
    self:ElvUI_ActionBar_SkinBar(_G.ElvUI_StanceBar, "STANCE")
end

function S:SkinZoneAbilities(button)
    for spellButton in button.SpellButtonContainer:EnumerateActive() do
        if spellButton and spellButton.IsSkinned then
            self:CreateShadow(spellButton)
        end
    end
end

function S:ElvUI_ActionBar_LoadKeyBinder()
    local frame = _G.ElvUIBindPopupWindow
    if not frame then
        self:SecureHook(AB, "LoadKeyBinder", "ElvUI_ActionBar_LoadKeyBinder")
        return
    end

    self:CreateShadow(frame)
    self:CreateBackdropShadow(frame.header, true)
end

function S:ElvUI_ActionBars()
    if not (E.private.actionbar.enable and E.private.WT.skins.elvui.enable) then
        return
    end

    if not (E.private.WT.skins.elvui.actionBarsButton or E.private.WT.skins.elvui.actionBarsBackdrop) then
        return
    end

    -- 常规动作条
    for id = 1, 10 do
        local bar = _G["ElvUI_Bar" .. id]
        self:ElvUI_ActionBar_SkinBar(bar, "PLAYER")
    end

    self:SecureHook(AB, "PositionAndSizeBar", "ElvUI_ActionBar_PositionAndSizeBar")

    -- 宠物动作条
    self:ElvUI_ActionBar_SkinBar(_G.ElvUI_BarPet, "PET")
    self:SecureHook(AB, "PositionAndSizeBarPet", "ElvUI_ActionBar_PositionAndSizeBarPet")

    -- 姿态条
    self:ElvUI_ActionBar_SkinBar(_G.ElvUI_StanceBar, "STANCE")
    self:SecureHook(AB, "PositionAndSizeBarShapeShift", "ElvUI_ActionBar_PositionAndSizeBarShapeShift")

    if not E.private.WT.skins.elvui.actionBarsButton then
        return
    end

    -- 特殊技能
    self:SecureHook(_G.ZoneAbilityFrame, "UpdateDisplayedZoneAbilities", "SkinZoneAbilities")

    for i = 1, _G.ExtraActionBarFrame:GetNumChildren() do
        local button = _G["ExtraActionButton" .. i]
        if button then
            self:CreateShadow(button)
        end
    end

    -- 离开载具
    do
        local button = _G.MainMenuBarVehicleLeaveButton
        self:CreateBackdropShadow(button, true)
        local tex = button:GetNormalTexture()
        if tex then
            tex:SetTexture(W.Media.Textures.arrowDown)
            tex:SetTexCoord(0, 1, 0, 1)
            tex:SetVertexColor(1, 1, 1)
        end

        tex = button:GetPushedTexture()
        if tex then
            tex:SetTexture(W.Media.Textures.arrowDown)
            tex:SetTexCoord(0, 1, 0, 1)
            tex:SetVertexColor(1, 0, 0)
        end

        tex = button:GetHighlightTexture()
        if tex then
            tex:SetTexture(nil)
            tex:Hide()
        end
    end
    -- 额外动作条
    for i = 1, _G.ExtraActionBarFrame:GetNumChildren() do
        local button = _G["ExtraActionButton" .. i]
        self:CreateBackdropShadow(button.backdrop, true)
    end

    -- Flyout
    self:SecureHook(
        AB,
        "SetupFlyoutButton",
        function(_, button)
            self:CreateBackdropShadow(button, true)
        end
    )

    -- Keybind
    self:ElvUI_ActionBar_LoadKeyBinder()
end

S:AddCallback("ElvUI_ActionBars")
