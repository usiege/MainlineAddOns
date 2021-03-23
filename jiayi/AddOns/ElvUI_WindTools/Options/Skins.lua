local W, F, E, L, V, P, G = unpack(select(2, ...))
local options = W.options.skins.args
local LSM = E.Libs.LSM
local S = W:GetModule("Skins")

local pairs = pairs

local IsAddOnLoaded = IsAddOnLoaded

options.desc = {
    order = 1,
    type = "group",
    inline = true,
    name = L["Description"],
    args = {
        feature_1 = {
            order = 1,
            type = "description",
            name = L["WindTools provides a new shadow style for original ElvUI."],
            fontSize = "medium"
        },
        feature_2 = {
            order = 2,
            type = "description",
            name = L["You can customize the global shadow color, disable some skins, set the level of vignetting, etc."],
            fontSize = "medium"
        },
        feature_3 = {
            order = 3,
            type = "description",
            name = L["WindSkins is all in control, enjoy your own ElvUI interface!"],
            fontSize = "medium"
        }
    }
}

options.general = {
    order = 2,
    type = "group",
    name = L["General"],
    get = function(info)
        return E.private.WT.skins[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.skins[info[#info]] = value
        E:StaticPopup_Show("PRIVATE_RL")
    end,
    args = {
        enable = {
            order = 1,
            type = "toggle",
            name = L["Enable"]
        },
        merathilisUISkin = {
            order = 2,
            type = "toggle",
            name = format(L["Use %s Skins"], L["MerathilisUI"]),
            desc = format(
                "%s\n|cffff0000%s|r: %s",
                format(L["Add skins for all modules inside %s with %s functions."], L["WindTools"], L["MerathilisUI"]),
                L["Notice"],
                format(L["It doesn't means that the %s Skins will not be applied."], L["WindTools"])
            ),
            hidden = function()
                return not IsAddOnLoaded("ElvUI_MerathilisUI")
            end
        },
        general = {
            order = 3,
            type = "group",
            name = L["General"],
            inline = true,
            disabled = function()
                return not E.private.WT.skins.enable
            end,
            args = {
                windtools = {
                    order = 1,
                    type = "toggle",
                    name = L["WindTools Modules"]
                },
                removeParchment = {
                    order = 2,
                    type = "toggle",
                    name = L["Parchment Remover"]
                }
            }
        },
        shadow = {
            order = 4,
            type = "group",
            name = L["Shadow"],
            inline = true,
            disabled = function()
                return not E.private.WT.skins.enable
            end,
            args = {
                shadow = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"]
                },
                increasedSize = {
                    order = 2,
                    type = "range",
                    name = L["Increase Size"],
                    desc = L["Make shadow thicker."],
                    min = 0,
                    max = 10,
                    step = 1
                },
                color = {
                    order = 3,
                    type = "color",
                    name = L["Shadow Color"],
                    hasAlpha = false,
                    get = function(info)
                        local db = E.private.WT.skins.color
                        local default = V.skins.color
                        return db.r, db.g, db.b, nil, default.r, default.g, default.b, nil
                    end,
                    set = function(info, r, g, b)
                        local db = E.private.WT.skins.color
                        db.r, db.g, db.b = r, g, b
                        E:StaticPopup_Show("PRIVATE_RL")
                    end,
                    disabled = function()
                        return not E.private.WT.skins.enable
                    end
                }
            }
        },
        vignetting = {
            order = 5,
            type = "group",
            name = L["Vignetting"],
            inline = true,
            get = function(info)
                return E.db.WT.skins.vignetting[info[#info]]
            end,
            set = function(info, value)
                E.db.WT.skins.vignetting[info[#info]] = value
                S:UpdateVignettingConfig()
            end,
            disabled = function()
                return not E.private.WT.skins.enable
            end,
            args = {
                enable = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"]
                },
                level = {
                    order = 2,
                    type = "range",
                    name = L["Level"],
                    desc = L["Change the alpha of vignetting."],
                    disabled = function()
                        return not E.db.WT.skins.vignetting.enable
                    end,
                    min = 1,
                    max = 100,
                    step = 1
                }
            }
        }
    }
}

options.font = {
    order = 3,
    type = "group",
    name = L["Font"],
    args = {
        errorMessage = {
            order = 1,
            type = "group",
            inline = true,
            name = L["Error Mesage"],
            get = function(info)
                return E.private.WT.skins.errorMessage[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.skins.errorMessage[info[#info]] = value
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
        },
        imeLabel = {
            order = 2,
            type = "group",
            inline = true,
            name = L["Input Method Editor"] .. " - " .. L["Label"],
            get = function(info)
                return E.private.WT.skins.ime.label[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.skins.ime.label[info[#info]] = value
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
        },
        imeCandidate = {
            order = 3,
            type = "group",
            inline = true,
            name = L["Input Method Editor"] .. " - " .. L["Candidate"],
            get = function(info)
                return E.private.WT.skins.ime.candidate[info[#info]]
            end,
            set = function(info, value)
                E.private.WT.skins.ime.candidate[info[#info]] = value
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

options.blizzard = {
    order = 4,
    type = "group",
    name = L["Blizzard"],
    get = function(info)
        return E.private.WT.skins.blizzard[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.skins.blizzard[info[#info]] = value
        E:StaticPopup_Show("PRIVATE_RL")
    end,
    disabled = function()
        return not E.private.WT.skins.enable
    end,
    args = {
        enable = {
            order = 0,
            type = "toggle",
            name = L["Enable"]
        },
        enableAll = {
            order = 1,
            type = "execute",
            name = L["Enable All"],
            func = function()
                for key in pairs(V.skins.blizzard) do
                    E.private.WT.skins.blizzard[key] = true
                end
                E:StaticPopup_Show("PRIVATE_RL")
            end
        },
        disableAll = {
            order = 2,
            type = "execute",
            name = L["Disable All"],
            func = function()
                for key in pairs(V.skins.blizzard) do
                    if key ~= "enable" then
                        E.private.WT.skins.blizzard[key] = false
                    end
                end
                E:StaticPopup_Show("PRIVATE_RL")
            end
        },
        betterOption = {
            order = 3,
            type = "description",
            name = " ",
            width = "full"
        },
        achievements = {
            order = 10,
            type = "toggle",
            name = L["Achievements"]
        },
        addonManager = {
            order = 10,
            type = "toggle",
            name = L["AddOn Manager"]
        },
        adventureMap = {
            order = 10,
            type = "toggle",
            name = L["Adventure Map"]
        },
        alerts = {
            order = 10,
            type = "toggle",
            name = L["Alert Frames"]
        },
        animaDiversion = {
            order = 10,
            type = "toggle",
            name = L["Anima Diversion"]
        },
        artifact = {
            order = 10,
            type = "toggle",
            name = L["Artifact"]
        },
        auctionHouse = {
            order = 10,
            type = "toggle",
            name = L["Auction House"]
        },
        azerite = {
            order = 10,
            type = "toggle",
            name = L["Azerite"]
        },
        azeriteEssence = {
            order = 10,
            type = "toggle",
            name = L["Azerite Essence"]
        },
        azeriteRespec = {
            order = 10,
            type = "toggle",
            name = L["Azerite Respec"]
        },
        barberShop = {
            order = 10,
            type = "toggle",
            name = L["Barber Shop"]
        },
        binding = {
            order = 10,
            type = "toggle",
            name = L["Binding"]
        },
        blackMarket = {
            order = 10,
            type = "toggle",
            name = L["Black Market"]
        },
        calendar = {
            order = 10,
            type = "toggle",
            name = L["Calendar"]
        },
        challenges = {
            order = 10,
            type = "toggle",
            name = L["Challenges"]
        },
        channels = {
            order = 10,
            type = "toggle",
            name = L["Channels"]
        },
        character = {
            order = 10,
            type = "toggle",
            name = L["Character"]
        },
        chromieTime = {
            order = 10,
            type = "toggle",
            name = L["Chromie Time"]
        },
        collections = {
            order = 10,
            type = "toggle",
            name = L["Collections"]
        },
        communities = {
            order = 10,
            type = "toggle",
            name = L["Communities"]
        },
        covenantRenown = {
            order = 10,
            type = "toggle",
            name = L["Covenant Renown"]
        },
        covenantPreview = {
            order = 10,
            type = "toggle",
            name = L["Covenant Preview"]
        },
        covenantSanctum = {
            order = 10,
            type = "toggle",
            name = L["Covenant Sanctum"]
        },
        debugTools = {
            order = 10,
            type = "toggle",
            name = L["Debug Tools"]
        },
        dressingRoom = {
            order = 10,
            type = "toggle",
            name = L["Dressing Room"]
        },
        encounterJournal = {
            order = 10,
            type = "toggle",
            name = L["Encounter Journal"]
        },
        friends = {
            order = 10,
            type = "toggle",
            name = L["Friend List"]
        },
        flightMap = {
            order = 10,
            type = "toggle",
            name = L["Flight Map"]
        },
        garrison = {
            order = 10,
            type = "toggle",
            name = L["Garrison"]
        },
        gossip = {
            order = 10,
            type = "toggle",
            name = L["Gossip Frame"]
        },
        guildBank = {
            order = 10,
            type = "toggle",
            name = L["Guild Bank"]
        },
        help = {
            order = 10,
            type = "toggle",
            name = L["Help Frame"]
        },
        inputMethodEditor = {
            order = 10,
            type = "toggle",
            name = L["Input Method Editor"]
        },
        inspect = {
            order = 10,
            type = "toggle",
            name = L["Inspect"]
        },
        lookingForGroup = {
            order = 10,
            type = "toggle",
            name = L["Looking For Group"]
        },
        loot = {
            order = 10,
            type = "toggle",
            name = L["Loot Frames"]
        },
        lossOfControl = {
            order = 10,
            type = "toggle",
            name = L["Loss Of Control"]
        },
        macro = {
            order = 10,
            type = "toggle",
            name = L["Macros"]
        },
        mail = {
            order = 10,
            type = "toggle",
            name = L["Mail Frame"]
        },
        merchant = {
            order = 10,
            type = "toggle",
            name = L["Merchant"]
        },
        microButtons = {
            order = 10,
            type = "toggle",
            name = L["Micro Bar"]
        },
        mirrorTimers = {
            order = 10,
            type = "toggle",
            name = L["Mirror Timers"]
        },
        misc = {
            order = 10,
            type = "toggle",
            name = L["Misc Frames"]
        },
        objectiveTracker = {
            order = 10,
            type = "toggle",
            name = L["Objective Tracker"]
        },
        orderHall = {
            order = 10,
            type = "toggle",
            name = L["Orderhall"]
        },
        petBattle = {
            order = 10,
            type = "toggle",
            name = L["Pet Battle"]
        },
        quest = {
            order = 10,
            type = "toggle",
            name = L["Quest Frames"]
        },
        raidInfo = {
            order = 10,
            type = "toggle",
            name = L["Raid Info"]
        },
        scenario = {
            order = 10,
            type = "toggle",
            name = L["Scenario"]
        },
        scrappingMachine = {
            order = 10,
            type = "toggle",
            name = L["Scrapping Machine"]
        },
        soulbinds = {
            order = 10,
            type = "toggle",
            name = L["Soulbinds"]
        },
        spellBook = {
            order = 10,
            type = "toggle",
            name = L["Spell Book"]
        },
        staticPopup = {
            order = 10,
            type = "toggle",
            name = L["Static Popup"]
        },
        subscriptionInterstitial = {
            order = 10,
            type = "toggle",
            name = L["Subscription Interstitial"]
        },
        talent = {
            order = 10,
            type = "toggle",
            name = L["Talents"]
        },
        talkingHead = {
            order = 10,
            type = "toggle",
            name = L["Talking Head"]
        },
        taxi = {
            order = 10,
            type = "toggle",
            name = L["Taxi"]
        },
        timeManager = {
            order = 10,
            type = "toggle",
            name = L["Stopwatch"]
        },
        tooltips = {
            order = 10,
            type = "toggle",
            name = L["Tooltips"]
        },
        trade = {
            order = 10,
            type = "toggle",
            name = L["Trade"]
        },
        tradeSkill = {
            order = 10,
            type = "toggle",
            name = L["Trade Skill"]
        },
        trainer = {
            order = 10,
            type = "toggle",
            name = L["Trainer"]
        },
        tutorial = {
            order = 10,
            type = "toggle",
            name = L["Tutorials"]
        },
        warboard = {
            order = 10,
            type = "toggle",
            name = L["Warboard"]
        },
        weeklyRewards = {
            order = 10,
            type = "toggle",
            name = L["Weekly Rewards"]
        },
        worldMap = {
            order = 10,
            type = "toggle",
            name = L["World Map"]
        }
    }
}

for key, value in pairs(options.blizzard.args) do
    if key ~= "enable" then
        value.disabled = function()
            return not E.private.WT.skins.blizzard.enable
        end
    end
end

options.elvui = {
    order = 5,
    type = "group",
    name = L["ElvUI"],
    get = function(info)
        return E.private.WT.skins.elvui[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.skins.elvui[info[#info]] = value
        E:StaticPopup_Show("PRIVATE_RL")
    end,
    disabled = function()
        return not E.private.WT.skins.enable
    end,
    args = {
        enable = {
            order = 0,
            type = "toggle",
            name = L["Enable"]
        },
        enableAll = {
            order = 1,
            type = "execute",
            name = L["Enable All"],
            func = function()
                for key in pairs(V.skins.elvui) do
                    E.private.WT.skins.elvui[key] = true
                end
                E:StaticPopup_Show("PRIVATE_RL")
            end
        },
        disableAll = {
            order = 2,
            type = "execute",
            name = L["Disable All"],
            func = function()
                for key in pairs(V.skins.elvui) do
                    if key ~= "enable" then
                        E.private.WT.skins.elvui[key] = false
                    end
                end
                E:StaticPopup_Show("PRIVATE_RL")
            end
        },
        betterOption = {
            order = 3,
            type = "description",
            name = " ",
            width = "full"
        },
        actionBarsBackdrop = {
            order = 10,
            type = "toggle",
            name = L["Actionbars Backdrop"]
        },
        actionBarsButton = {
            order = 10,
            type = "toggle",
            name = L["Actionbars Button"]
        },
        afk = {
            order = 10,
            type = "toggle",
            name = L["AFK Mode"]
        },
        altPowerBar = {
            order = 10,
            type = "toggle",
            name = L["Alt Power"]
        },
        auras = {
            order = 10,
            type = "toggle",
            name = L["Auras"]
        },
        bags = {
            order = 10,
            type = "toggle",
            name = L["Bags"]
        },
        castBars = {
            order = 10,
            type = "toggle",
            name = L["Cast Bar"]
        },
        chatDataPanels = {
            order = 10,
            type = "toggle",
            name = L["Chat Data Panels"]
        },
        chatPanels = {
            order = 10,
            type = "toggle",
            name = L["Chat Panels"]
        },
        classBars = {
            order = 10,
            type = "toggle",
            name = L["Class Bars"]
        },
        chatCopyFrame = {
            order = 10,
            type = "toggle",
            name = L["Chat Copy Frame"]
        },
        dataBars = {
            order = 10,
            type = "toggle",
            name = L["Data Bars"]
        },
        dataPanels = {
            order = 10,
            type = "toggle",
            name = L["Data Panels"]
        },
        miniMap = {
            order = 10,
            type = "toggle",
            name = L["Minimap"]
        },
        option = {
            order = 10,
            type = "toggle",
            name = L["Options"]
        },
        panels = {
            order = 10,
            type = "toggle",
            name = L["Panels"]
        },
        raidUtility = {
            order = 10,
            type = "toggle",
            name = L["Raid Utility"]
        },
        staticPopup = {
            order = 10,
            type = "toggle",
            name = L["Static Popup"]
        },
        statusReport = {
            order = 10,
            type = "toggle",
            name = L["Status Report"]
        },
        totemBar = {
            order = 10,
            type = "toggle",
            name = L["Totem Bar"]
        },
        unitFrames = {
            order = 10,
            type = "toggle",
            name = L["UnitFrames"]
        }
    }
}

for key, value in pairs(options.elvui.args) do
    if key ~= "enable" then
        value.disabled = function()
            return not E.private.WT.skins.elvui.enable
        end
    end
end

-- If the skin is in development, add this: .." |cffff0000["..L["Test"].."]|r"
options.addons = {
    order = 6,
    type = "group",
    name = L["Addons"],
    get = function(info)
        return E.private.WT.skins.addons[info[#info]]
    end,
    set = function(info, value)
        E.private.WT.skins.addons[info[#info]] = value
        E:StaticPopup_Show("PRIVATE_RL")
    end,
    disabled = function()
        return not E.private.WT.skins.enable
    end,
    args = {
        enableAll = {
            order = 1,
            type = "execute",
            name = L["Enable All"],
            func = function()
                for key in pairs(V.skins.addons) do
                    E.private.WT.skins.addons[key] = true
                end
                E:StaticPopup_Show("PRIVATE_RL")
            end
        },
        disableAll = {
            order = 2,
            type = "execute",
            name = L["Disable All"],
            func = function()
                for key in pairs(V.skins.addons) do
                    E.private.WT.skins.addons[key] = false
                end
                E:StaticPopup_Show("PRIVATE_RL")
            end
        },
        descGroup = {
            order = 3,
            type = "group",
            name = " ",
            inline = true,
            args = {
                desc = {
                    order = 1,
                    type = "description",
                    name = format(
                        "|cffff0000%s|r %s",
                        L["Notice"],
                        L["Skins only work if you installed and loaded the addon."]
                    ),
                    width = "full",
                    fontSize = "medium"
                }
            }
        },
        betterOption = {
            order = 9,
            type = "description",
            name = " ",
            width = "full"
        },
        ace3 = {
            order = 10,
            type = "toggle",
            name = L["Ace3"]
        },
        azerothAutoPilot = {
            order = 10,
            type = "toggle",
            name = L["Azeroth Auto Pilot"]
        },
        bigWigs = {
            order = 10,
            type = "toggle",
            name = L["BigWigs"]
        },
        bigWigsQueueTimer = {
            order = 10,
            type = "toggle",
            name = L["BigWigs Queue Timer"]
        },
        bugSack = {
            order = 10,
            type = "toggle",
            name = L["BugSack"]
        },
        hekili = {
            order = 10,
            type = "toggle",
            name = L["Hekili"]
        },
        immersion = {
            order = 10,
            type = "toggle",
            name = L["Immersion"]
        },
        meetingStone = {
            order = 10,
            type = "toggle",
            name = L["NetEase Meeting Stone"]
        },
        myslot = {
            order = 10,
            type = "toggle",
            name = L["Myslot"]
        },
        mythicDungeonTools = {
            order = 10,
            type = "toggle",
            name = L["Mythic Dungeon Tools"]
        },
        premadeGroupsFilter = {
            order = 10,
            type = "toggle",
            name = L["Premade Groups Filter"]
        },
        rehack = {
            order = 10,
            type = "toggle",
            name = L["REHack"]
        },
        rematch = {
            order = 10,
            type = "toggle",
            name = L["Rematch"]
        },
        tinyInspect = {
            order = 10,
            type = "toggle",
            name = L["TinyInspect"]
        },
        weakAuras = {
            order = 10,
            type = "toggle",
            name = L["WeakAuras"]
        },
        weakAurasOptions = {
            order = 10,
            type = "toggle",
            name = L["WeakAuras Options"]
        }
    }
}
