local W, F, E, L, V, P, G = unpack(select(2, ...))
local LSM = E.Libs.LSM
local C = W:GetModule("CombatAlert")
local RM = W:GetModule("RaidMarkers")
local TM = W:GetModule("TalentManager")
local QK = W:GetModule("QuickKeystone")

local options = W.options.combat.args

options.raidMarkers = {
    order = 1,
    type = "group",
    name = L["Raid Markers"],
    args = {
        desc = {
            order = 1,
            type = "group",
            inline = true,
            name = L["Description"],
            args = {
                feature = {
                    order = 1,
                    type = "description",
                    name = L["Add an extra bar to let you set raid markers efficiently."],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"],
            desc = L["Toggle raid markers bar."],
            get = function(info)
                return E.db.WT.combat.raidMarkers[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.combat.raidMarkers[info[#info]] = value
                RM:ProfileUpdate()
            end
        },
        inverse = {
            order = 3,
            type = "toggle",
            name = L["Inverse Mode"],
            desc = L["Swap the functionality of normal click and click with modifier keys."],
            get = function(info)
                return E.db.WT.combat.raidMarkers[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.combat.raidMarkers[info[#info]] = value
                RM:ToggleSettings()
            end,
            disabled = function()
                return not E.db.WT.combat.raidMarkers.enable
            end,
            width = 2
        },
        visibilityConfig = {
            order = 4,
            type = "group",
            inline = true,
            name = L["Visibility"],
            get = function(info)
                return E.db.WT.combat.raidMarkers[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.combat.raidMarkers[info[#info]] = value
                RM:ToggleSettings()
            end,
            disabled = function()
                return not E.db.WT.combat.raidMarkers.enable
            end,
            args = {
                visibility = {
                    type = "select",
                    order = 1,
                    name = L["Visibility"],
                    values = {
                        DEFAULT = L["Default"],
                        INPARTY = L["In Party"],
                        ALWAYS = L["Always Display"]
                    }
                },
                mouseOver = {
                    order = 2,
                    type = "toggle",
                    name = L["Mouse Over"],
                    desc = L["Only show raid markers bar when you mouse over it."]
                },
                tooltip = {
                    order = 3,
                    type = "toggle",
                    name = L["Tooltip"],
                    desc = L["Show the tooltip when you mouse over the button."]
                },
                modifier = {
                    order = 4,
                    type = "select",
                    name = L["Modifier Key"],
                    desc = L["Set the modifier key for placing world markers."],
                    values = {
                        shift = L["Shift Key"],
                        ctrl = L["Ctrl Key"],
                        alt = L["Alt Key"]
                    }
                }
            }
        },
        barConfig = {
            order = 5,
            type = "group",
            inline = true,
            name = L["Raid Markers Bar"],
            get = function(info)
                return E.db.WT.combat.raidMarkers[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.combat.raidMarkers[info[#info]] = value
                RM:ToggleSettings()
            end,
            disabled = function()
                return not E.db.WT.combat.raidMarkers.enable
            end,
            args = {
                backdrop = {
                    order = 1,
                    type = "toggle",
                    name = L["Bar Backdrop"],
                    desc = L["Show a backdrop of the bar."]
                },
                backdropSpacing = {
                    order = 2,
                    type = "range",
                    name = L["Backdrop Spacing"],
                    desc = L["The spacing between the backdrop and the buttons."],
                    min = 1,
                    max = 30,
                    step = 1
                },
                orientation = {
                    order = 3,
                    type = "select",
                    name = L["Orientation"],
                    desc = L["Arrangement direction of the bar."],
                    values = {
                        HORIZONTAL = L["Horizontal"],
                        VERTICAL = L["Vertical"]
                    }
                }
            }
        },
        raidButtons = {
            order = 6,
            type = "group",
            inline = true,
            name = L["Raid Buttons"],
            get = function(info)
                return E.db.WT.combat.raidMarkers[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.combat.raidMarkers[info[#info]] = value
                RM:UpdateBar()
            end,
            disabled = function()
                return not E.db.WT.combat.raidMarkers.enable
            end,
            args = {
                readyCheck = {
                    order = 1,
                    type = "toggle",
                    name = L["Ready Check"] .. " / " .. L["Advanced Combat Logging"],
                    desc = format(
                        "%s\n%s",
                        L["Left Click to ready check."],
                        L["Right click to toggle advanced combat logging."]
                    ),
                    width = 2
                },
                countDown = {
                    order = 2,
                    type = "toggle",
                    name = L["Count Down"]
                },
                countDownTime = {
                    order = 3,
                    type = "range",
                    name = L["Count Down Time"],
                    desc = L["Count down time in seconds."],
                    min = 1,
                    max = 30,
                    step = 1
                }
            }
        },
        buttonsConfig = {
            order = 7,
            type = "group",
            inline = true,
            name = L["Buttons"],
            get = function(info)
                return E.db.WT.combat.raidMarkers[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.combat.raidMarkers[info[#info]] = value
                RM:ToggleSettings()
            end,
            disabled = function()
                return not E.db.WT.combat.raidMarkers.enable
            end,
            args = {
                buttonSize = {
                    order = 1,
                    type = "range",
                    name = L["Button Size"],
                    desc = L["The size of the buttons."],
                    min = 15,
                    max = 60,
                    step = 1
                },
                spacing = {
                    order = 2,
                    type = "range",
                    name = L["Button Spacing"],
                    desc = L["The spacing between buttons."],
                    min = 1,
                    max = 30,
                    step = 1
                }
            }
        }
    }
}

options.combatAlert = {
    order = 2,
    type = "group",
    name = L["Combat Alert"],
    desc = L["Show a alert when you enter or leave combat."],
    get = function(info)
        return E.db.WT.combat.combatAlert[info[#info]]
    end,
    set = function(info, value)
        E.db.WT.combat.combatAlert[info[#info]] = value
        C:ProfileUpdate()
    end,
    args = {
        desc = {
            order = 1,
            type = "group",
            inline = true,
            name = L["Description"],
            args = {
                feature = {
                    order = 1,
                    type = "description",
                    name = L[
                        "This module will display a alert frame when entering and leaving combat.\n" ..
                            "You can customize animations and text effects."
                    ],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"]
        },
        speed = {
            order = 3,
            type = "range",
            name = L["Speed"],
            desc = L["The speed of the alert."],
            min = 0.1,
            max = 4,
            step = 0.01
        },
        preview = {
            order = 4,
            type = "execute",
            name = L["Preview"],
            desc = L["Preview the alert visual effect."],
            func = function()
                C:Preview()
            end
        },
        animationConfig = {
            order = 5,
            type = "group",
            inline = true,
            name = L["Animation"],
            args = {
                animation = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"],
                    desc = L["Display an animation when you enter or leave combat."]
                },
                animationSize = {
                    order = 2,
                    type = "range",
                    name = L["Animation Size"],
                    desc = L["The speed of the alert."],
                    min = 0.1,
                    max = 3,
                    step = 0.01
                }
            }
        },
        textConfig = {
            order = 6,
            type = "group",
            inline = true,
            name = L["Text"],
            args = {
                text = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"],
                    desc = L["Display a text when you enter or leave combat."]
                },
                enterText = {
                    order = 2,
                    type = "input",
                    name = L["Enter Text"]
                },
                enterColor = {
                    order = 3,
                    type = "color",
                    name = L["Enter Color"],
                    get = function(info)
                        local db = E.db.WT.combat.combatAlert[info[#info]]
                        local default = P.combat.combatAlert[info[#info]]
                        return db.r, db.g, db.b, db.a, default.r, default.g, default.b, default.a
                    end,
                    set = function(info, r, g, b, a)
                        local db = E.db.WT.combat.combatAlert[info[#info]]
                        db.r, db.g, db.b, db.a = r, g, b, a
                    end
                },
                leaveText = {
                    order = 4,
                    type = "input",
                    name = L["Leave Text"]
                },
                leaveColor = {
                    order = 5,
                    type = "color",
                    name = L["Leave Color"],
                    get = function(info)
                        local db = E.db.WT.combat.combatAlert[info[#info]]
                        local default = P.combat.combatAlert[info[#info]]
                        return db.r, db.g, db.b, db.a, default.r, default.g, default.b, default.a
                    end,
                    set = function(info, r, g, b, a)
                        local db = E.db.WT.combat.combatAlert[info[#info]]
                        db.r, db.g, db.b, db.a = r, g, b, a
                    end
                },
                font = {
                    type = "group",
                    order = 6,
                    name = L["Font Setting"],
                    get = function(info)
                        return E.db.WT.combat.combatAlert[info[#info - 1]][info[#info]]
                    end,
                    set = function(info, value)
                        E.db.WT.combat.combatAlert[info[#info - 1]][info[#info]] = value
                        C:ProfileUpdate()
                    end,
                    args = {
                        name = {
                            order = 1,
                            type = "select",
                            dialogControl = "LSM30_Font",
                            name = L["Font"],
                            values = LSM:HashTable("font")
                        },
                        style = {
                            order = 2,
                            type = "select",
                            name = L["Outline"],
                            values = {
                                NONE = L["None"],
                                OUTLINE = L["OUTLINE"],
                                MONOCHROME = L["MONOCHROME"],
                                MONOCHROMEOUTLINE = L["MONOCROMEOUTLINE"],
                                THICKOUTLINE = L["THICKOUTLINE"]
                            }
                        },
                        size = {
                            order = 3,
                            name = L["Size"],
                            type = "range",
                            min = 5,
                            max = 60,
                            step = 1
                        }
                    }
                }
            }
        }
    }
}

options.talentManager = {
    order = 3,
    type = "group",
    name = L["Talent Manager"],
    desc = L["Save and learn talents by one-click."],
    get = function(info)
        return E.private.WT.combat.talentManager[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.combat.talentManager[info[#info]] = value
        E:StaticPopup_Show("PRIVATE_RL")
    end,
    args = {
        desc = {
            order = 1,
            type = "group",
            inline = true,
            name = L["Description"],
            args = {
                feature = {
                    order = 1,
                    type = "description",
                    name = L["Save and learn talents by one-click."],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"]
        },
        pvpTalent = {
            order = 3,
            type = "toggle",
            name = L["PvP Talents"]
        },
        itemButtons = {
            order = 4,
            type = "toggle",
            name = L["Item Buttons"],
            desc = L["Add tomb and codex buttons."]
        },
        statusIcon = {
            order = 5,
            type = "toggle",
            name = L["Status Icon"],
            desc = L["Add an icon indicates the status of the permission of changing talents."]
        },
        clearSets = {
            order = 6,
            type = "execute",
            name = L["Clear All Sets"],
            func = function()
                E.private.WT.combat.talentManager.sets = {}
                TM:UpdateSetButtons()
            end
        }
    }
}

options.quickKeystone = {
    order = 4,
    name = L["Quick Keystone"],
    type = "group",
    get = function(info)
        return E.db.WT.combat.quickKeystone[info[#info]]
    end,
    set = function(info, value)
        E.db.WT.combat.quickKeystone[info[#info]] = value
        QK:ProfileUpdate()
    end,
    args = {
        desc = {
            order = 1,
            type = "group",
            inline = true,
            name = L["Description"],
            args = {
                feature = {
                    order = 1,
                    type = "description",
                    name = L["Put the keystone from bag automatically."],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"],
            width = "full"
        }
    }
}
