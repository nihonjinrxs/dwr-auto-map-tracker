local game = require('game')
local data = require('data')

local function withMax(value, maxValue)
    return string.format("%d / %d", value, maxValue)
end

local function generatePrintablesLeft(data)
    local romData = game.getROMInfo()
    local pl = {
        "ROM Name: "..romData.filename,
        "ROM Hash: "..romData.hash,
    }
    if not data.map.id then
        return pl
    end
    pl[#pl + 1] = "Hero Stats"
    pl[#pl + 1] = string.format(" Level  % 5d", data.hero.stats.level)
    pl[#pl + 1] = string.format(" XP     % 5d", data.hero.stats.xp)
    pl[#pl + 1] = string.format(" HP % 3d / % 3d", data.hero.stats.hp, data.hero.stats.hpMax)
    pl[#pl + 1] = string.format(" MP % 3d / % 3d", data.hero.stats.mp. data.hero.stats.mpMax)
    pl[#pl + 1] = string.format(" STR    % 5d", data.hero.stats.strength)
    pl[#pl + 1] = string.format(" AGI    % 5d", data.hero.stats.agility)
    pl[#pl + 1] = string.format(" AP     % 5d", data.hero.stats.attack)
    pl[#pl + 1] = string.format(" DP     % 5d", data.hero.stats.defense)
    pl[#pl + 1] = string.format(" Gold   % 5d", data.hero.gold)
    pl[#pl + 1] = "Hero Equipment"
    pl[#pl + 1] = string.format(" W %s", data.hero.equipment.weapon or "")
    pl[#pl + 1] = string.format(" A %s", data.hero.equipment.armor or "")
    pl[#pl + 1] = string.format(" S %s", data.hero.equipment.shield or "")
    pl[#pl + 1] = "Equipped Items"
    local equipped_items = " "
    if data.hero.equipped.dragon_scale then equipped_items = equipped_items.."DScl" end
    if data.hero.equipped.fighter_ring then equipped_items = equipped_items.."FRng" end
    if data.hero.equipped.death_necklace then equipped_items = equipped_items.."DthN" end
    if data.hero.equipped.cursed_belt then equipped_items = equipped_items.."CBlt" end
    pl[#pl + 1] = "Quest Items"
    local quest_items = " "
    if data.here.quest_items.dragon_scale then quest_items = quest_items.."DScl" end
    if data.here.quest_items.fighter_ring then quest_items = quest_items.."FRng" end
    if data.here.quest_items.death_necklace then quest_items = quest_items.."DthN" end
    if data.here.quest_items.gwaelin_love then quest_items = quest_items.."GwPS" end
    if data.here.quest_items.erdrick_token then quest_items = quest_items.."Tokn" end
    if data.here.quest_items.silver_harp then quest_items = quest_items.."Harp" end
    if data.here.quest_items.stones_of_sunlight then quest_items = quest_items.."SSun" end
    if data.here.quest_items.staff_of_rain then quest_items = quest_items.."Rain" end
    if data.here.quest_items.rainbow_drop then quest_items = quest_items.."Drop" end
    if data.here.quest_progress.rainbow_bridge then quest_items = quest_items.."RbBr" end
    if data.here.quest_items.ball_of_light then quest_items = quest_items.."Ball" end
    return pl
end

local function generatePrintablesRight(data)
    local romData = game.getROMInfo()
    local pl = {
        "ROM Name: "..romData.filename,
        "ROM Hash: "..romData.hash,
    }
    if not data.map.id then
        return pl
    end
    pl[#pl + 1] = "Spells"
    pl[#pl + 1] = string.format(" %s HEAL      ", data.hero.spells.HEAL and "+" or " ")
    pl[#pl + 1] = string.format(" %s HURT      ", data.hero.spells.HURT and "+" or " ")
    pl[#pl + 1] = string.format(" %s SLEEP     ", data.hero.spells.SLEEP and "+" or " ")
    pl[#pl + 1] = string.format(" %s RADIANT   ", data.hero.spells.RADIANT and "+" or " ")
    pl[#pl + 1] = string.format(" %s STOPSPELL ", data.hero.spells.STOPSPELL and "+" or " ")
    pl[#pl + 1] = string.format(" %s OUTSIDE   ", data.hero.spells.OUTSIDE and "+" or " ")
    pl[#pl + 1] = string.format(" %s RETURN    ", data.hero.spells.RETURN and "+" or " ")
    pl[#pl + 1] = string.format(" %s REPEL     ", data.hero.spells.REPEL and "+" or " ")
    pl[#pl + 1] = string.format(" %s HEALMORE  ", data.hero.spells.HEALMORE and "+" or " ")
    pl[#pl + 1] = string.format(" %s HURTMORE  ", data.hero.spells.HURTMORE and "+" or " ")
    pl[#pl + 1] = "Items"
    pl[#pl + 1] = string.format(" Key         %d", data.hero.items.magic_key)
    pl[#pl + 1] = string.format(" Herb        %d", data.hero.items.herb)
    pl[#pl + 1] = string.format(" Torch       %d", data.hero.items.torch)
    pl[#pl + 1] = string.format(" Wings       %d", data.hero.items.wings)
    pl[#pl + 1] = string.format(" Fairy Water %d", data.hero.items.fairy_water)
    pl[#pl + 1] = string.format(" Cursed Belt %d", data.hero.items.cursed_belt)
    return pl
end

local function displayOSD(data)
    print("")
    print("")
    local leftSide = generatePrintablesLeft(data)
    local textX = game.screenDimensions.minX + 2
    local textY = game.screenDimensions.minY + 2
    local printablesCount = #(leftSide)
    for i = 1,printablesCount do
        gui.text(textX, textY, leftSide[i])
        textY = textY + 10
    end
    local rightSide = generatePrintablesRight(data)
    local textX = game.screenDimensions.maxX - 8 * 13 - 2
    local textY = game.screenDimensions.minY + 2
    local printablesCount = #(rightSide)
    for i = 1,printablesCount do
        gui.text(textX, textY, rightSide[i])
        textY = textY + 10
    end
end

--Produces a compact, uncluttered representation of a table. Mutual recursion is employed
--source: http://lua-users.org/wiki/TableUtils
function table.val_to_str ( v )
    if "string" == type( v ) then
      v = string.gsub( v, "\n", "\\n" )
      if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
        return "'" .. v .. "'"
      end
      return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
    else
      return "table" == type( v ) and table.tostring( v ) or
        tostring( v )
    end
end
function table.key_to_str ( k )
    if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
        return k
    else
        return "[" .. table.val_to_str( k ) .. "]"
    end
  end
function table.tostring( tbl )
    local result, done = {}, {}
    for k, v in ipairs( tbl ) do
        table.insert( result, table.val_to_str( v ) )
        done[ k ] = true
    end
    for k, v in pairs( tbl ) do
        if not done[ k ] then
        table.insert( result,
            table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
        end
    end
    return "{" .. table.concat( result, "," ) .. "}"
end

local function logValues(data)
    print(table.tostring(data))
end

return {
    displayOSD = displayOSD,
    logValues = logValues,
}
