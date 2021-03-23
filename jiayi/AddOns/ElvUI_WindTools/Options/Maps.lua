local W, F, E, L, V, P, G = unpack(select(2, ...))
local options = W.options.maps.args
local LSM = E.Libs.LSM
local MB = W:GetModule("MinimapButtons")
local WC = W:GetModule("WhoClicked")
local RM = W:GetModule("RectangleMinimap")
local WM = W:GetModule("WorldMap")

local format = format

options.superTracker = {
    order = 1,
    type = "group",
    name = L["Super Tracker"],
    get = function(info)
        return E.private.WT.maps.superTracker[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.maps.superTracker[info[#info]] = value
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
                    name = L["Additional features for waypoint."],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"],
            width = "full"
        },
        general = {
            order = 3,
            type = "group",
            inline = true,
            name = L["General"],
            args = {
                autoTrackWaypoint = {
                    order = 1,
                    type = "toggle",
                    name = L["Auto Track Waypoint"],
                    desc = L["Auto track the waypoint after setting."],
                    width = 1.5
                },
                rightClickToClear = {
                    order = 2,
                    type = "toggle",
                    name = L["Right Click To Clear"],
                    desc = L["Right click the waypoint to clear it."],
                    width = 1.5
                },
                noLimit = {
                    order = 3,
                    type = "toggle",
                    name = L["No Distance Limitation"],
                    desc = L["Force to track the target even if it over 1000 yds."],
                    width = 1.5
                }
            }
        },
        distanceText = {
            order = 4,
            type = "group",
            name = L["Distance Text"],
            inline = true,
            get = function(info)
                return E.private.WT.maps.superTracker.distanceText[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.maps.superTracker.distanceText[info[#info]] = value
                E:StaticPopup_Show("PRIVATE_RL")
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
                },
                color = {
                    order = 4,
                    type = "color",
                    name = L["Color"],
                    get = function(info)
                        local db = E.private.WT.maps.superTracker.distanceText[info[#info]]
                        local default = V.maps.superTracker.distanceText[info[#info]]
                        return db.r, db.g, db.b, nil, default.r, default.g, default.b, nil
                    end,
                    set = function(info, r, g, b, a)
                        local db = E.private.WT.maps.superTracker.distanceText[info[#info]]
                        db.r, db.g, db.b, db.a = r, g, b, nil
                        E:StaticPopup_Show("PRIVATE_RL")
                    end
                },
                onlyNumber = {
                    order = 5,
                    type = "toggle",
                    name = L["Only Number"],
                    desc = L["Remove the unit from distance text."]
                }
            }
        }
    }
}

options.whoClicked = {
    order = 2,
    type = "group",
    name = L["Who Clicked Minimap"],
    get = function(info)
        return E.db.WT.maps.whoClicked[info[#info]]
    end,
    set = function(info, value)
        E.db.WT.maps.whoClicked[info[#info]] = value
        WC:ProfileUpdate()
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
                    name = L["Display the name of the player who clicked the minimap."],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"],
            width = "full"
        },
        general = {
            order = 3,
            type = "group",
            inline = true,
            name = L["General"],
            args = {
                addRealm = {
                    order = 1,
                    type = "toggle",
                    name = L["Add Server Name"]
                },
                onlyOnCombat = {
                    order = 2,
                    type = "toggle",
                    name = L["Only On Combat"]
                }
            }
        },
        position = {
            order = 4,
            type = "group",
            inline = true,
            name = L["Position"],
            args = {
                xOffset = {
                    order = 1,
                    type = "range",
                    name = L["X-Offset"],
                    min = -200,
                    max = 200,
                    step = 1
                },
                yOffset = {
                    order = 2,
                    type = "range",
                    name = L["Y-Offset"],
                    min = -200,
                    max = 200,
                    step = 1
                }
            }
        },
        animation = {
            order = 5,
            type = "group",
            inline = true,
            name = L["Animation Duration"],
            args = {
                fadeInTime = {
                    order = 1,
                    type = "range",
                    name = L["Fade In"],
                    desc = L["The time of animation. Set 0 to disable animation."],
                    min = 0,
                    max = 5,
                    step = 0.1
                },
                stayTime = {
                    order = 2,
                    type = "range",
                    name = L["Stay"],
                    desc = L["The time of animation. Set 0 to disable animation."],
                    min = 0,
                    max = 10,
                    step = 0.1
                },
                fadeOutTime = {
                    order = 3,
                    type = "range",
                    name = L["Fade Out"],
                    desc = L["The time of animation. Set 0 to disable animation."],
                    min = 0,
                    max = 5,
                    step = 0.1
                }
            }
        },
        color = {
            order = 6,
            type = "group",
            inline = true,
            name = L["Color"],
            args = {
                classColor = {
                    order = 1,
                    type = "toggle",
                    name = L["Use Class Color"]
                },
                customColor = {
                    order = 2,
                    type = "color",
                    name = L["Custom Color"],
                    get = function(info)
                        local db = E.db.WT.maps.whoClicked[info[#info]]
                        local default = P.maps.whoClicked[info[#info]]
                        return db.r, db.g, db.b, nil, default.r, default.g, default.b, nil
                    end,
                    set = function(info, r, g, b, a)
                        local db = E.db.WT.maps.whoClicked[info[#info]]
                        db.r, db.g, db.b, db.a = r, g, b, nil
                    end
                }
            }
        },
        font = {
            order = 7,
            type = "group",
            inline = true,
            name = L["Font Setting"],
            get = function(info)
                return E.db.WT.maps.whoClicked.font[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.maps.whoClicked.font[info[#info]] = value
                WC:ProfileUpdate()
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

options.rectangleMinimap = {
    order = 3,
    type = "group",
    name = L["Rectangle Minimap"],
    get = function(info)
        return E.db.WT.maps.rectangleMinimap[info[#info]]
    end,
    set = function(info, value)
        E.db.WT.maps.rectangleMinimap[info[#info]] = value
        RM:ChangeShape()
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
                    name = L["Change the shape of ElvUI minimap."],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"],
            width = "full"
        },
        heightPercentage = {
            order = 3,
            type = "range",
            name = L["Height Percentage"],
            desc = L["Percentage of ElvUI minimap size."],
            min = 0.01,
            max = 1,
            step = 0.01
        }
    }
}

options.minimapButtons = {
    order = 4,
    type = "group",
    name = L["Minimap Buttons"],
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
                    name = L["Add an extra bar to collect minimap buttons."],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"],
            desc = L["Toggle minimap buttons bar."],
            get = function(info)
                return E.private.WT.maps.minimapButtons[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.maps.minimapButtons[info[#info]] = value
                E:StaticPopup_Show("PRIVATE_RL")
            end
        },
        mouseOver = {
            order = 3,
            type = "toggle",
            name = L["Mouse Over"],
            desc = L["Only show minimap buttons bar when you mouse over it."],
            get = function(info)
                return E.private.WT.maps.minimapButtons[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.maps.minimapButtons[info[#info]] = value
                MB:UpdateMouseOverConfig()
            end
        },
        barConfig = {
            order = 4,
            type = "group",
            inline = true,
            name = L["Minimap Buttons Bar"],
            get = function(info)
                return E.private.WT.maps.minimapButtons[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.maps.minimapButtons[info[#info]] = value
                MB:UpdateLayout()
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
                    min = 0,
                    max = 30,
                    step = 1
                },
                inverseDirection = {
                    order = 3,
                    type = "toggle",
                    name = L["Inverse Direction"],
                    desc = L["Reverse the direction of adding buttons."]
                },
                orientation = {
                    order = 4,
                    type = "select",
                    name = L["Orientation"],
                    desc = L["Arrangement direction of the bar."],
                    values = {
                        NOANCHOR = L["Drag"],
                        HORIZONTAL = L["Horizontal"],
                        VERTICAL = L["Vertical"]
                    },
                    set = function(info, value)
                        E.private.WT.maps.minimapButtons[info[#info]] = value
                        -- 如果开启日历美化的话，需要重载来取消掉美化
                        if value == "NOANCHOR" and E.private.WT.maps.minimapButtons.calendar then
                            E:StaticPopup_Show("PRIVATE_RL")
                        else
                            MB:UpdateLayout()
                        end
                    end
                }
            }
        },
        buttonsConfig = {
            order = 5,
            type = "group",
            inline = true,
            name = L["Buttons"],
            get = function(info)
                return E.private.WT.maps.minimapButtons[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.maps.minimapButtons[info[#info]] = value
                MB:UpdateLayout()
            end,
            args = {
                buttonsPerRow = {
                    order = 1,
                    type = "range",
                    name = L["Buttons Per Row"],
                    desc = L["The amount of buttons to display per row."],
                    min = 1,
                    max = 30,
                    step = 1
                },
                buttonSize = {
                    order = 2,
                    type = "range",
                    name = L["Button Size"],
                    desc = L["The size of the buttons."],
                    get = function(info)
                        return E.private.WT.maps.minimapButtons[info[#info]]
                    end,
                    set = function(info, value)
                        E.private.WT.maps.minimapButtons[info[#info]] = value
                        MB:SkinMinimapButtons()
                    end,
                    min = 15,
                    max = 60,
                    step = 1
                },
                spacing = {
                    order = 3,
                    type = "range",
                    name = L["Button Spacing"],
                    desc = L["The spacing between buttons."],
                    min = 0,
                    max = 30,
                    step = 1
                }
            }
        },
        blizzardButtonsConfig = {
            order = 6,
            type = "group",
            inline = true,
            name = L["Blizzard Buttons"],
            get = function(info)
                return E.private.WT.maps.minimapButtons[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.maps.minimapButtons[info[#info]] = value
                E:StaticPopup_Show("PRIVATE_RL")
            end,
            args = {
                calendar = {
                    order = 1,
                    type = "toggle",
                    name = L["Calendar"],
                    desc = L["Add calendar button to the bar."]
                },
                garrison = {
                    order = 2,
                    type = "toggle",
                    name = L["Garrison"],
                    desc = L["Add garrison button to the bar."]
                }
            }
        }
    }
}

options.worldMap = {
    order = 5,
    type = "group",
    name = L["World Map"],
    get = function(info)
        return E.private.WT.maps.worldMap[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.maps.worldMap[info[#info]] = value
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
                    name = function()
                        if WM.StopRunning then
                            return format(
                                "|cffff0000" .. L["Because of %s, this module will not be loaded."] .. "|r",
                                WM.StopRunning
                            )
                        else
                            return L["This module will help you to reveal and resize maps."]
                        end
                    end,
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"]
        },
        reveal = {
            order = 3,
            type = "toggle",
            name = L["Remove Fog"],
            desc = L["Remove Fog of War from your world map."]
        },
        scale = {
            order = 4,
            type = "group",
            inline = true,
            name = L["Scale"],
            desc = L["Resize world map."],
            get = function(info)
                return E.private.WT.maps.worldMap.scale[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.maps.worldMap.scale[info[#info]] = value
                E:StaticPopup_Show("PRIVATE_RL")
            end,
            args = {
                enable = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"],
                    desc = L["Resize world map."]
                },
                size = {
                    order = 2,
                    type = "range",
                    name = L["Size"],
                    min = 0.1,
                    max = 3,
                    step = 0.01
                }
            }
        }
    }
}

options.instanceDifficulty = {
    order = 6,
    type = "group",
    name = L["Instance Difficulty"],
    get = function(info)
        return E.private.WT.maps.instanceDifficulty[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.maps.instanceDifficulty[info[#info]] = value
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
                    name = L["Reskin the instance diffculty in text style."],
                    fontSize = "medium"
                }
            }
        },
        enable = {
            order = 2,
            type = "toggle",
            name = L["Enable"]
        },
        align = {
            order = 3,
            type = "select",
            name = L["Text Align"],
            values = {
                LEFT = L["Left"],
                CENTER = L["Center"],
                RIGHT = L["Right"]
            }
        },
        hideBlizzard = {
            order = 4,
            type = "toggle",
            name = L["Hide Blizzard Indicator"]
        },
        font = {
            order = 5,
            type = "group",
            name = L["Font"],
            inline = true,
            get = function(info)
                return E.private.WT.maps.instanceDifficulty.font[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.maps.instanceDifficulty.font[info[#info]] = value
                E:StaticPopup_Show("PRIVATE_RL")
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
