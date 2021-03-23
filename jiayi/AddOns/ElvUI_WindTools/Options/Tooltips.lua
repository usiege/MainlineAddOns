local W, F, E, L, V, P, G = unpack(select(2, ...))
local options = W.options.tooltips.args
local T = W:GetModule("Tooltips")

local ipairs = ipairs

options.desc = {
    order = 1,
    type = "group",
    inline = true,
    name = L["Description"],
    args = {
        feature = {
            order = 1,
            type = "description",
            name = L["Add some additional information to your tooltips."],
            fontSize = "medium"
        }
    }
}

options.general = {
    order = 2,
    type = "group",
    name = L["General"],
    get = function(info)
        return E.private.WT.tooltips[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.tooltips[info[#info]] = value
        E:StaticPopup_Show("PRIVATE_RL")
    end,
    args = {
        additionalInformation = {
            order = 1,
            type = "group",
            inline = true,
            name = L["Additional Information"],
            args = {
                icon = {
                    order = 3,
                    type = "toggle",
                    name = L["Add Icon"],
                    desc = L["Show an icon for items and spells."]
                }
            }
        },
        objectiveProgressInformation = {
            order = 2,
            type = "group",
            inline = true,
            name = L["Objective Progress"],
            args = {
                objectiveProgress = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"],
                    desc = L["Add more details of objective progress information into tooltips."]
                },
                objectiveProgressAccuracy = {
                    order = 2,
                    name = L["Accuracy"],
                    type = "range",
                    min = 0,
                    max = 5,
                    step = 1
                }
            }
        },
        healthBar = {
            order = 3,
            type = "group",
            inline = true,
            name = L["Health Bar"],
            get = function(info)
                return E.db.WT.tooltips[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.tooltips[info[#info]] = value
            end,
            args = {
                yOffsetOfHealthBar = {
                    order = 1,
                    type = "range",
                    name = L["Health Bar Y-Offset"],
                    desc = L["Change the postion of the health bar."],
                    min = -50,
                    max = 50,
                    step = 1
                },
                yOffsetOfHealthText = {
                    order = 2,
                    type = "range",
                    name = L["Health Text Y-Offset"],
                    desc = L["Change the postion of the health text."],
                    min = -50,
                    max = 50,
                    step = 1
                }
            }
        },
        groupInfo = {
            order = 4,
            type = "group",
            inline = true,
            get = function(info)
                return E.db.WT.tooltips.groupInfo[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.tooltips.groupInfo[info[#info]] = value
            end,
            name = L["Group Info"],
            args = {
                enable = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"],
                    desc = L["Add LFG group info to tooltip."]
                },
                title = {
                    order = 2,
                    type = "toggle",
                    name = L["Add Title"],
                    desc = L["Display an additional title."]
                },
                mode = {
                    order = 3,
                    name = L["Mode"],
                    type = "select",
                    values = {
                        NORMAL = L["Normal"],
                        COMPACT = L["Compact"]
                    }
                }
            }
        }
    }
}

options.progression = {
    order = 3,
    type = "group",
    name = L["Progression"],
    get = function(info)
        return E.private.WT.tooltips.progression[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.tooltips.progression[info[#info]] = value
        E:StaticPopup_Show("PRIVATE_RL")
    end,
    args = {
        enable = {
            order = 1,
            type = "toggle",
            name = L["Enable"],
            desc = L["Add progression information to tooltips."]
        },
        raids = {
            order = 2,
            type = "group",
            name = L["Raids"],
            inline = true,
            get = function(info)
                return E.private.WT.tooltips.progression.raids[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.tooltips.progression.raids[info[#info]] = value
                E:StaticPopup_Show("PRIVATE_RL")
            end,
            disabled = function()
                return not E.private.WT.tooltips.progression.enable
            end,
            args = {
                enable = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"]
                }
            }
        },
        mythicDungeons = {
            order = 2,
            type = "group",
            name = L["Mythic Dungeons"],
            inline = true,
            get = function(info)
                return E.private.WT.tooltips.progression.mythicDungeons[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.tooltips.progression.mythicDungeons[info[#info]] = value
                E:StaticPopup_Show("PRIVATE_RL")
            end,
            disabled = function()
                return not E.private.WT.tooltips.progression.enable
            end,
            args = {
                enable = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"]
                }
            }
        },
        special = {
            order = 3,
            type = "group",
            name = L["Special Achievements"],
            inline = true,
            get = function(info)
                return E.private.WT.tooltips.progression.special[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.tooltips.progression.special[info[#info]] = value
                E:StaticPopup_Show("PRIVATE_RL")
            end,
            disabled = function()
                return not E.private.WT.tooltips.progression.enable
            end,
            args = {
                enable = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"]
                }
            }
        }
    }
}

do
    local raids = {
        "Castle Nathria"
    }

    local dungeons = {
        "The Necrotic Wake",
        "Plaguefall",
        "Mists of Tirna Scithe",
        "Halls of Atonement",
        "Theater of Pain",
        "De Other Side",
        "Spires of Ascension",
        "Sanguine Depths"
    }

    local special = {
        "Shadowlands Keystone Master: Season One"
    }

    for index, name in ipairs(raids) do
        options.progression.args.raids.args[name] = {
            order = index + 1,
            type = "toggle",
            name = L[name],
            disabled = function()
                return not (E.private.WT.tooltips.progression.enable and E.private.WT.tooltips.progression.raids.enable)
            end
        }
    end

    for index, name in ipairs(dungeons) do
        options.progression.args.mythicDungeons.args[name] = {
            order = index + 2,
            type = "toggle",
            name = L[name],
            disabled = function()
                return not (E.private.WT.tooltips.progression.enable and
                    E.private.WT.tooltips.progression.mythicDungeons.enable)
            end
        }
    end

    for index, name in ipairs(special) do
        options.progression.args.special.args[name] = {
            order = index + 2,
            type = "toggle",
            name = L[name],
            width = "full",
            disabled = function()
                return not (E.private.WT.tooltips.progression.enable and
                    E.private.WT.tooltips.progression.special.enable)
            end
        }
    end
end
