require 'auxlib'

local data = require 'data'
local map = require 'map'

local MAP_DISPLAY_SCALER = 2

local function displaySpell(spellName, learned)
    return iup.label{
        title=spellName,
        color=(learned and "black" or "grey")
    }
end

local function displayAllSpells(config)
    local labels = {
        displaySpell("HEAL", data.Data.hero.spells.HEAL),
        displaySpell("HURT", data.Data.hero.spells.HURT),
        displaySpell("SLEEP", data.Data.hero.spells.SLEEP),
        displaySpell("RADIANT", data.Data.hero.spells.RADIANT),
        displaySpell("STOPSPELL", data.Data.hero.spells.STOPSPELL),
        displaySpell("OUTSIDE", data.Data.hero.spells.OUTSIDE),
        displaySpell("RETURN", data.Data.hero.spells.RETURN),
        displaySpell("REPEL", data.Data.hero.spells.REPEL),
        displaySpell("HEALMORE", data.Data.hero.spells.HEALMORE),
        displaySpell("HURTMORE", data.Data.hero.spells.HURTMORE)
    }
    local result = {}
    local n = 0
    for _,v in ipairs(labels) do n=n+1; result[n]=v end
    for k,v in ipairs(config) do result[k]=v end

    return result
end

function initUI()
    local mapImage = iup.image(map.data)

	dialogs = dialogs + 1; -- there is no ++ in Lua
	handles[dialogs] = iup.dialog{
        title="Dragon Warrior Randomizer Auto-Tracker",
        iup.hbox{
            iup.hbox{
                iup.frame{
                    title="Map",
                    iup.canvas{
                        bgcolor="128 255 0",
                        height=map.height * MAP_DISPLAY_SCALER,
                        width=map.width * MAP_DISPLAY_SCALER,
                        image=mapImage
                    },
                    alignment="ACENTER",
                    margin="10x10"
                }, -- /frame
            }, -- /hbox
            iup.vbox{
                iup.frame{
                    title="Hero Stats",
                    iup.vbox{
                        iup.label{
                            title=string.format(" Level  % 5d", data.Data.hero.stats.level)
                        },
                        iup.label{
                            title=string.format(" XP     % 5d", data.Data.hero.stats.xp)
                        },
                        iup.label{
                            title=string.format(" HP % 3d / % 3d", data.Data.hero.stats.hp, data.Data.hero.stats.hpMax)
                        },
                        iup.label{
                            title=string.format(" MP % 3d / % 3d", data.Data.hero.stats.mp, data.Data.hero.stats.mpMax)
                        },
                        iup.label{
                            title=string.format(" STR    % 5d", data.Data.hero.stats.strength)
                        },
                        iup.label{
                            title=string.format(" AGI    % 5d", data.Data.hero.stats.agility)
                        },
                        iup.label{
                            title=string.format(" AP     % 5d", data.Data.hero.stats.attack)
                        },
                        iup.label{
                            title=string.format(" DP     % 5d", data.Data.hero.stats.defense)
                        },
                        iup.label{
                            title=string.format(" Gold   % 5d", data.Data.hero.gold)
                        },
                        alignment="ALEFT",
                        margin="5x5"
                    } -- /vbox
                }, -- /frame
                iup.frame{
                    title = "Hero Equipment",
                    iup.vbox{
                        iup.label{
                            title=string.format(" W %s", data.Data.hero.equipment.weapon or "")
                        },
                        iup.label{
                            title=string.format(" A %s", data.Data.hero.equipment.armor or "")
                        },
                        iup.label{
                            title=string.format(" S %s", data.Data.hero.equipment.shield or "")
                        },
                        alignment="ALEFT",
                        margin="5x5"
                    } -- /vbox
                }, -- /frame
                iup.frame{
                    title = "Hero Spells",
                    iup.vbox(displayAllSpells({
                        alignment="ALEFT",
                        margin="5x5",
                    }))
                }, -- /frame
            }, -- /vbox
        }, -- /hbox
        gap="10",
        alignment="JUST",
        margin="5x5"
    } -- /dialog

    -- this actually shows you the dialog. Note that this is equivalent to calling handles[dialogs].show(handles[dialogs]); just shorter.
    handles[dialogs]:show();
end

return {
    initUI = initUI
}
