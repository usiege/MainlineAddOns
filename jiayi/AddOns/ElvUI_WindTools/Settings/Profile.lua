local W, F, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

local GetLocale = GetLocale

P.announcement = {
    enable = true,
    combatResurrection = {
        enable = true,
        onlySourceIsPlayer = false,
        raidWarning = false,
        text = L["%player% cast %spell% -> %target%"],
        channel = {
            solo = "NONE",
            party = "PARTY",
            instance = "INSTANCE_CHAT",
            raid = "RAID"
        }
    },
    goodbye = {
        enable = true,
        text = L["Thanks all!"],
        delay = 3,
        channel = {
            party = "PARTY",
            instance = "INSTANCE_CHAT",
            raid = "RAID"
        }
    },
    interrupt = {
        enable = true,
        onlyInstance = true,
        player = {
            enable = true,
            text = L["I interrupted %target%'s %target_spell%!"],
            channel = {
                solo = "SELF",
                party = "PARTY",
                instance = "INSTANCE_CHAT",
                raid = "RAID"
            }
        },
        others = {
            enable = false,
            text = L["%player% interrupted %target%'s %target_spell%!"],
            channel = {
                party = "EMOTE",
                instance = "NONE",
                raid = "NONE"
            }
        }
    },
    quest = {
        enable = false,
        paused = true,
        includeDetails = true,
        channel = {
            party = "PARTY",
            instance = "INSTANCE_CHAT",
            raid = "RAID"
        },
        tag = {
            enable = true,
            color = {r = 0.490, g = 0.373, b = 1.000}
        },
        suggestedGroup = {
            enable = true,
            color = {r = 1.000, g = 0.220, b = 0.220}
        },
        level = {
            enable = true,
            color = {r = 0.773, g = 0.424, b = 0.941},
            hideOnMax = true
        },
        daily = {
            enable = true,
            color = {r = 1.000, g = 0.980, b = 0.396}
        },
        weekly = {
            enable = true,
            color = {r = 0.196, g = 1.000, b = 0.494}
        }
    },
    resetInstance = {
        enable = true,
        prefix = true,
        channel = {
            party = "PARTY",
            instance = "INSTANCE_CHAT",
            raid = "RAID"
        }
    },
    taunt = {
        enable = false,
        player = {
            player = {
                enable = true,
                provokeAllText = L["I taunted all enemies in 10 yards!"],
                successText = L["I taunted %target% successfully!"],
                failedText = L["I failed on taunting %target%!"],
                channel = {
                    solo = "NONE",
                    party = "PARTY",
                    instance = "INSTANCE_CHAT",
                    raid = "RAID"
                }
            },
            pet = {
                enable = true,
                successText = L["My %pet_role% %pet% taunted %target% successfully!"],
                failedText = L["My %pet_role% %pet% failed on taunting %target%!"],
                channel = {
                    solo = "NONE",
                    party = "PARTY",
                    instance = "INSTANCE_CHAT",
                    raid = "RAID"
                }
            }
        },
        others = {
            player = {
                enable = true,
                provokeAllText = L["%player% taunted all enemies in 10 yards!"],
                successText = L["%player% taunted %target% successfully!"],
                failedText = L["%player% failed on taunting %target%!"],
                channel = {
                    party = "SELF",
                    instance = "SELF",
                    raid = "SELF"
                }
            },
            pet = {
                enable = true,
                successText = L["%player%'s %pet_role% %pet% taunted %target% successfully!"],
                failedText = L["%player%'s %pet_role% %pet% failed on taunting %target%!"],
                channel = {
                    party = "SELF",
                    instance = "SELF",
                    raid = "SELF"
                }
            }
        }
    },
    thanksForResurrection = {
        enable = true,
        normalText = L["%target%, thank you for using %spell% to revive me. :)"],
        soulstoneText = L["%target%, thank you for soulstone. :)"],
        delay = 0,
        channel = {
            solo = "WHISPER",
            party = "WHISPER",
            instance = "WHISPER",
            raid = "WHISPER"
        }
    },
    threatTransfer = {
        enable = true,
        onlyNotTank = true,
        forceSourceIsPlayer = true,
        forceDestIsPlayer = false,
        raidWarning = false,
        text = L["%player% cast %spell% -> %target%"],
        channel = {
            solo = "NONE",
            party = "PARTY",
            instance = "INSTANCE_CHAT",
            raid = "RAID"
        }
    },
    utility = {
        enable = true,
        channel = {
            solo = "NONE",
            party = "PARTY",
            instance = "INSTANCE_CHAT",
            raid = "RAID"
        },
        spells = {
            ["698"] = {
                -- 召喚儀式
                enable = true,
                includePlayer = true,
                raidWarning = true,
                text = L["%player% is casting %spell%, please assist!"]
            },
            ["29893"] = {
                -- 靈魂之井
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["%player% is handing out cookies, go and get one!"]
            },
            ["54710"] = {
                -- MOLL-E 郵箱
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["%player% puts %spell%"]
            },
            ["261602"] = {
                -- 凱蒂的郵哨
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["%player% used %spell%"]
            },
            ["195782"] = {
                -- 召喚月羽雕像
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["%player% used %spell%"]
            },
            ["190336"] = {
                -- 召喚餐點桌
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["%player% cast %spell%, today's special is Anchovy Pie!"]
            },
            feasts = {
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["OMG, wealthy %player% puts %spell%!"]
            },
            bots = {
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["%player% puts %spell%"]
            },
            toys = {
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["%player% puts %spell%"]
            },
            portals = {
                enable = true,
                includePlayer = true,
                raidWarning = false,
                text = L["%player% opened %spell%!"]
            }
        }
    },
    keystone = {
        enable = true,
        text = L["My new keystone is %keystone%."],
        channel = {
            party = "PARTY"
        }
    }
}

P.combat = {
    combatAlert = {
        enable = true,
        speed = 1,
        animation = true,
        animationSize = 1,
        text = true,
        enterText = L["Enter Combat"],
        leaveText = L["Leave Combat"],
        enterColor = {r = 0.929, g = 0.11, b = 0.141, a = 1},
        leaveColor = {r = 0.227, g = 1, b = 0.6, a = 1},
        font = {
            name = E.db.general.font,
            size = 25,
            style = "OUTLINE"
        }
    },
    raidMarkers = {
        enable = true,
        mouseOver = false,
        tooltip = true,
        visibility = "DEFAULT",
        backdrop = true,
        backdropSpacing = 3,
        buttonSize = 30,
        spacing = 4,
        orientation = "HORIZONTAL",
        modifier = "shift",
        readyCheck = true,
        countDown = true,
        countDownTime = 5,
        inverse = false
    },
    quickKeystone = {
        enable = true
    }
}

P.item = {
    contacts = {
        enable = true,
        defaultPage = "ALTS"
    },
    delete = {
        enable = true,
        delKey = true,
        fillIn = "CLICK"
    },
    alreadyKnown = {
        enable = true,
        mode = "COLOR",
        color = {
            r = 0,
            g = 1,
            b = 0
        }
    },
    fastLoot = {
        enable = true,
        limit = 0.3
    },
    trade = {
        enable = true,
        thanksButton = true,
        thanksText = L["Thank you!"]
    },
    extraItemsBar = {
        enable = true,
        customList = {},
        blackList = {
            [183040] = true
        },
        bar1 = {
            enable = true,
            mouseOver = false,
            globalFade = false,
            fadeTime = 0.3,
            alphaMin = 0,
            alphaMax = 1,
            numButtons = 12,
            backdrop = true,
            backdropSpacing = 3,
            buttonWidth = 35,
            buttonHeight = 30,
            buttonsPerRow = 12,
            anchor = "TOPLEFT",
            spacing = 3,
            tooltip = true,
            countFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            bindFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            include = "QUEST,BANNER,EQUIP,TORGHAST,OPENABLE"
        },
        bar2 = {
            enable = true,
            mouseOver = false,
            globalFade = false,
            fadeTime = 0.3,
            alphaMin = 0,
            alphaMax = 1,
            numButtons = 12,
            backdrop = true,
            backdropSpacing = 3,
            buttonWidth = 35,
            buttonHeight = 30,
            buttonsPerRow = 12,
            anchor = "TOPLEFT",
            spacing = 3,
            tooltip = true,
            countFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            bindFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            include = "POTIONSL,FLASKSL,UTILITY"
        },
        bar3 = {
            enable = true,
            mouseOver = false,
            globalFade = false,
            fadeTime = 0.3,
            alphaMin = 0,
            alphaMax = 1,
            numButtons = 12,
            backdrop = true,
            backdropSpacing = 3,
            buttonWidth = 35,
            buttonHeight = 30,
            buttonsPerRow = 12,
            anchor = "TOPLEFT",
            spacing = 3,
            tooltip = true,
            countFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            bindFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            include = "MAGEFOOD,FOODVENDOR,FOODSL,CUSTOM"
        },
        bar4 = {
            enable = false,
            mouseOver = false,
            globalFade = false,
            fadeTime = 0.3,
            alphaMin = 0,
            alphaMax = 1,
            numButtons = 12,
            backdrop = true,
            backdropSpacing = 3,
            buttonWidth = 35,
            buttonHeight = 30,
            buttonsPerRow = 12,
            anchor = "TOPLEFT",
            spacing = 3,
            tooltip = true,
            countFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            bindFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            include = "CUSTOM"
        },
        bar5 = {
            enable = false,
            mouseOver = false,
            globalFade = false,
            fadeTime = 0.3,
            alphaMin = 0,
            alphaMax = 1,
            numButtons = 12,
            backdrop = true,
            backdropSpacing = 3,
            buttonWidth = 35,
            buttonHeight = 30,
            buttonsPerRow = 12,
            anchor = "TOPLEFT",
            spacing = 3,
            tooltip = true,
            countFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            bindFont = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE",
                xOffset = 0,
                yOffset = 0,
                color = {
                    r = 1,
                    g = 1,
                    b = 1
                }
            },
            include = "CUSTOM"
        }
    },
    inspect = {
        enable = true,
        player = true,
        inspect = true,
        stats = true,
        playerOnInspect = true,
        levelText = {
            name = F.GetCompatibleFont("Montserrat"),
            size = 13,
            style = "OUTLINE"
        },
        equipText = {
            name = E.db.general.font,
            size = 13,
            style = "OUTLINE"
        },
        statsText = {
            name = E.db.general.font,
            size = 13,
            style = "OUTLINE"
        }
    }
}

P.maps = {
    rectangleMinimap = {
        enable = false,
        heightPercentage = 0.8
    },
    whoClicked = {
        enable = true,
        xOffset = 0,
        yOffset = 2,
        fadeInTime = 0.5,
        stayTime = 3,
        fadeOutTime = 0.5,
        addRealm = false,
        onlyOnCombat = true,
        classColor = true,
        customColor = {r = 1, g = 1, b = 1},
        font = {
            name = E.db.general.font,
            size = 14,
            style = "OUTLINE"
        }
    }
}

P.skins = {
    vignetting = {
        enable = true,
        level = 30
    }
}

P.social = {
    chatBar = {
        enable = true,
        style = "BLOCK",
        blockShadow = true,
        autoHide = false,
        mouseOver = false,
        backdrop = false,
        backdropSpacing = 3,
        buttonWidth = 40,
        buttonHeight = 5,
        spacing = 5,
        orientation = "HORIZONTAL",
        tex = "WindTools Glow",
        font = {
            name = E.db.general.font,
            size = 12,
            style = "OUTLINE"
        },
        color = true,
        channels = {
            ["SAY"] = {
                enable = true,
                cmd = "s",
                color = {r = 1, g = 1, b = 1, a = 1},
                abbr = L["[ABBR] Say"]
            },
            ["YELL"] = {
                enable = true,
                cmd = "y",
                color = {r = 1, g = 0.25, b = 0.25, a = 1},
                abbr = L["[ABBR] Yell"]
            },
            ["EMOTE"] = {
                enable = false,
                cmd = "e",
                color = {r = 1, g = 0.5, b = 0.25, a = 1},
                abbr = L["[ABBR] Emote"]
            },
            ["PARTY"] = {
                enable = true,
                cmd = "p",
                color = {r = 0.67, g = 0.67, b = 1, a = 1},
                abbr = L["[ABBR] Party"]
            },
            ["INSTANCE"] = {
                enable = true,
                cmd = "i",
                color = {r = 1, g = 0.73, b = 0.2, a = 1},
                abbr = L["[ABBR] Instance"]
            },
            ["RAID"] = {
                enable = true,
                cmd = "raid",
                color = {r = 1, g = 0.5, b = 0, a = 1},
                abbr = L["[ABBR] Raid"]
            },
            ["RAID_WARNING"] = {
                enable = false,
                cmd = "rw",
                color = {r = 1, g = 0.28, b = 0, a = 1},
                abbr = L["[ABBR] Raid Warning"]
            },
            ["GUILD"] = {
                enable = true,
                cmd = "g",
                color = {r = 0.25, g = 1, b = 0.25, a = 1},
                abbr = L["[ABBR] Guild"]
            },
            ["OFFICER"] = {
                enable = false,
                cmd = "o",
                color = {r = 0.25, g = 0.75, b = 0.25, a = 1},
                abbr = L["[ABBR] Officer"]
            },
            world = {
                enable = false,
                autoJoin = true,
                name = "",
                color = {r = 0.2, g = 0.6, b = 0.86, a = 1},
                abbr = L["[ABBR] World"]
            },
            community = {
                enable = false,
                name = "",
                color = {r = 0.72, g = 0.27, b = 0.86, a = 1},
                abbr = L["[ABBR] Community"]
            },
            emote = {
                enable = true,
                icon = true,
                color = {r = 1, g = 0.33, b = 0.52, a = 1},
                abbr = L["[ABBR] Wind Emote"]
            },
            roll = {
                enable = true,
                icon = true,
                color = {r = 0.56, g = 0.56, b = 0.56, a = 1},
                abbr = L["[ABBR] Roll"]
            }
        }
    },
    chatLink = {
        enable = true,
        level = true,
        icon = true,
        armorCategory = true,
        weaponCategory = true,
        compatibile = true
    },
    chatText = {
        enable = true,
        abbreviation = "SHORT",
        removeBrackets = true,
        roleIconSize = 16,
        roleIconStyle = "SUNUI",
        removeRealm = true,
        customAbbreviation = {}
    },
    emote = {
        enable = true,
        size = 16,
        panel = true,
        chatBubbles = true
    },
    friendList = {
        enable = true,
        hideMaxLevel = true,
        useGameColor = true,
        useClassColor = true,
        textures = {
            game = "Modern",
            status = "Square",
            factionIcon = false
        },
        areaColor = {
            r = 1,
            g = 1,
            b = 1
        },
        nameFont = {
            name = E.db.general.font,
            size = 13,
            style = "OUTLINE"
        },
        infoFont = {
            name = E.db.general.font,
            size = 12,
            style = "OUTLINE"
        }
    },
    filter = {
        enable = true,
        unblockProfanityFilter = true
    },
    contextMenu = {
        enable = true,
        armory = E.global.general.locale ~= "zhCN",
        armoryOverride = {},
        addFriend = true,
        guildInvite = true,
        who = true,
        reportStats = true
    },
    smartTab = {
        enable = true,
        whisperCycle = false,
        yell = false,
        battleground = false,
        raidWarning = false,
        officer = false,
        historyLimit = 10
    }
}

P.quest = {
    paragonReputation = {
        enable = true,
        color = {r = 0, g = .5, b = .9},
        text = "DEFICIT",
        toast = {
            enable = true,
            sound = true,
            fade_time = 5
        }
    },
    switchButtons = {
        enable = true,
        font = {
            name = E.db.general.font,
            size = 12,
            style = "OUTLINE",
            color = {r = 1, g = 0.82, b = 0}
        },
        backdrop = false,
        announcement = true,
        turnIn = true
    },
    turnIn = {
        enable = true,
        selectReward = true,
        darkmoon = true,
        followerAssignees = true,
        rogueClassHallInsignia = true,
        modifierKeyPause = true,
        customIgnoreNPCs = {}
    }
}

P.tooltips = {
    yOffsetOfHealthBar = 0,
    yOffsetOfHealthText = 0,
    groupInfo = {
        enable = true,
        title = true,
        mode = "NORMAL"
    }
}

P.unitFrames = {
    castBar = {
        enable = false,
        player = {
            enable = false,
            text = {
                anchor = "LEFT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = E.db.general.font,
                    size = 12,
                    style = "OUTLINE"
                }
            },
            time = {
                anchor = "RIGHT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = F.GetCompatibleFont("Montserrat"),
                    size = 12,
                    style = "OUTLINE"
                }
            }
        },
        target = {
            enable = false,
            text = {
                anchor = "LEFT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = E.db.general.font,
                    size = 12,
                    style = "OUTLINE"
                }
            },
            time = {
                anchor = "RIGHT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = F.GetCompatibleFont("Montserrat"),
                    size = 12,
                    style = "OUTLINE"
                }
            }
        },
        pet = {
            enable = false,
            text = {
                anchor = "LEFT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = E.db.general.font,
                    size = 12,
                    style = "OUTLINE"
                }
            },
            time = {
                anchor = "RIGHT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = F.GetCompatibleFont("Montserrat"),
                    size = 12,
                    style = "OUTLINE"
                }
            }
        },
        focus = {
            enable = false,
            text = {
                anchor = "LEFT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = E.db.general.font,
                    size = 12,
                    style = "OUTLINE"
                }
            },
            time = {
                anchor = "RIGHT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = F.GetCompatibleFont("Montserrat"),
                    size = 12,
                    style = "OUTLINE"
                }
            }
        },
        boss = {
            enable = false,
            text = {
                anchor = "LEFT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = E.db.general.font,
                    size = 12,
                    style = "OUTLINE"
                }
            },
            time = {
                anchor = "RIGHT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = F.GetCompatibleFont("Montserrat"),
                    size = 12,
                    style = "OUTLINE"
                }
            }
        },
        arena = {
            enable = false,
            text = {
                anchor = "LEFT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = E.db.general.font,
                    size = 12,
                    style = "OUTLINE"
                }
            },
            time = {
                anchor = "RIGHT",
                offsetX = 0,
                offsetY = 0,
                font = {
                    name = F.GetCompatibleFont("Montserrat"),
                    size = 12,
                    style = "OUTLINE"
                }
            }
        }
    }
}

P.misc = {
    disableTalkingHead = false,
    HideCrafter = false,
    gameBar = {
        enable = true,
        mouseOver = false,
        backdrop = true,
        backdropSpacing = 5,
        timeAreaWidth = 110,
        timeAreaHeight = 50,
        buttonSize = 24,
        spacing = 4,
        fadeTime = 0.618,
        normalColor = "NONE",
        hoverColor = "CLASS",
        customNormalColor = {r = 1, g = 1, b = 1},
        customHoverColor = {r = 0, g = 0.659, b = 1},
        notification = true,
        visibility = "[petbattle] hide; show",
        tooltipsAnchor = "ANCHOR_BOTTOM",
        time = {
            localTime = true,
            twentyFour = true,
            flash = true,
            interval = 10,
            alwaysSystemInfo = false,
            font = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 25,
                style = "OUTLINE"
            }
        },
        home = {
            left = "6948",
            right = "141605"
        },
        additionalText = {
            enable = true,
            slowMode = true,
            anchor = "BOTTOMRIGHT",
            x = 3,
            y = -3,
            font = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 12,
                style = "OUTLINE"
            }
        },
        left = {
            [1] = "CHARACTER",
            [2] = "SPELLBOOK",
            [3] = "TALENTS",
            [4] = "FRIENDS",
            [5] = "GUILD",
            [6] = "GROUP_FINDER",
            [7] = "SCREENSHOT"
        },
        right = {
            [1] = "HOME",
            [2] = "ACHIEVEMENTS",
            [3] = "MISSION_REPORTS",
            [4] = "ENCOUNTER_JOURNAL",
            [5] = "TOY_BOX",
            [6] = "PET_JOURNAL",
            [7] = "BAGS"
        }
    }
}
