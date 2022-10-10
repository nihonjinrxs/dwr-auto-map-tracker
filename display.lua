local game = require('game')
-- local imageUtils = require('image_utils')
-- local gd = require('gd')

local function generatePrintablesLeft(data)
    -- local romData = game.getROMInfo()
    local pl = {
        -- "ROM Name: "..romData.filename,
        -- "ROM Hash: "..romData.hash,
    }
    if not data.map then
        return pl
    end
    if not data.map.id then
        return pl
    end
    pl[#pl + 1] = "Hero Stats"
    pl[#pl + 1] = string.format(" Level  % 5d", data.hero.stats.level)
    pl[#pl + 1] = string.format(" XP     % 5d", data.hero.stats.xp)
    pl[#pl + 1] = string.format(" HP % 3d / % 3d", data.hero.stats.hp, data.hero.stats.hpMax)
    pl[#pl + 1] = string.format(" MP % 3d / % 3d", data.hero.stats.mp, data.hero.stats.mpMax)
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
    if data.hero.equipped.dragon_scale then equipped_items = equipped_items.." DScl" end
    if data.hero.equipped.fighter_ring then equipped_items = equipped_items.." FRng" end
    if data.hero.equipped.death_necklace then equipped_items = equipped_items.." DthN" end
    if data.hero.equipped.cursed_belt then equipped_items = equipped_items.." CBlt" end
    pl[#pl + 1] = equipped_items
    pl[#pl + 1] = "Quest Items"
    local quest_items = " "
    if data.hero.quest_items.dragon_scale then quest_items = quest_items.." DScl" end
    if data.hero.quest_items.fighter_ring then quest_items = quest_items.." FRng" end
    if data.hero.quest_items.death_necklace then quest_items = quest_items.." DthN" end
    if data.hero.quest_items.gwaelin_love then quest_items = quest_items.." GwPS" end
    if data.hero.quest_items.erdrick_token then quest_items = quest_items.." Tokn" end
    if data.hero.quest_items.silver_harp then quest_items = quest_items.." Harp" end
    if data.hero.quest_items.stones_of_sunlight then quest_items = quest_items.." SSun" end
    if data.hero.quest_items.staff_of_rain then quest_items = quest_items.." Rain" end
    if data.hero.quest_items.rainbow_drop then quest_items = quest_items.." Drop" end
    if data.hero.quest_progress.rainbow_bridge then quest_items = quest_items.." RbBr" end
    if data.hero.quest_items.ball_of_light then quest_items = quest_items.." Ball" end
    pl[#pl + 1] = quest_items
    return pl
end

local function generatePrintablesRight(data)
    local pl = {}
    if not data.hero then
        return pl
    end
    if not data.hero.items.herb then
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
    pl[#pl + 1] = string.format(" Key         %d", data.hero.items.magic_key or 0)
    pl[#pl + 1] = string.format(" Herb        %d", data.hero.items.herb or 0)
    pl[#pl + 1] = string.format(" Torch        %d", data.hero.items.torch or 0)
    pl[#pl + 1] = string.format(" Wings        %d", data.hero.items.wings or 0)
    pl[#pl + 1] = string.format(" Fairy Water   %d", data.hero.items.fairy_water or 0)
    pl[#pl + 1] = string.format(" Cursed Belt   %d", data.hero.items.cursed_belt or 0)
    return pl
end

local function displayOSD(data)
    local textColor = "#CCEE00FF"
    local bgColor = "#00000066"
    -- print("")
    -- print("")
    local leftSide = generatePrintablesLeft(data)
    local textX = game.screenDimensions.minX + 2
    local textY = game.screenDimensions.minY + 2
    local printablesCount = #(leftSide)
    for i = 1,printablesCount do
        gui.text(textX, textY, leftSide[i], textColor, bgColor)
        textY = textY + 10
    end
    local rightSide = generatePrintablesRight(data)
    local textX = game.screenDimensions.maxX - 8 * 13 - 2
    local textY = game.screenDimensions.minY + 2
    local printablesCount = #(rightSide)
    for i = 1,printablesCount do
        gui.text(textX, textY, rightSide[i], textColor, bgColor)
        textY = textY + 10
    end

    -- local maxX = 255
    -- local maxY = 231
    -- local weaponImageFile = imageUtils.getWeaponImage(data.hero.equipment.weapon)
    -- if (weaponImageFile) then
    --     local gdstr = gd.createFromPng(weaponImageFile):gdStr()
    --     gui.gdoverlay(5, maxY - 35, gdstr)
    -- end
    -- local armorImageFile = imageUtils.getArmorImage(data.hero.equipment.armor)
    -- if (armorImageFile) then
    --     local gdstr = gd.createFromPng(armorImageFile):gdStr()
    --     gui.gdoverlay(40, maxY - 35, gdstr)
    -- end
    -- local shieldImageFile = imageUtils.getShieldImage(data.hero.equipment.shield)
    -- if (shieldImageFile) then
    --     local gdstr = gd.createFromPng(shieldImageFile):gdStr()
    --     gui.gdoverlay(75, maxY - 35, gdstr)
    -- end
end

local mapModule = require('map')

local function displayMap(map)
    local maxX = 255
    local maxY = 231
    if (not map.width) then
        map.width = 120
    end
    if (not map.height) then
        map.height = 120
    end
    local topLeft = { x = maxX-map.width-1, y = maxY-map.height-1 }
    gui.drawrect(topLeft.x+1, topLeft.y+1, topLeft.x+map.width+1, topLeft.y+map.height+1, "#00000066", "#CCEE00FF")

    local pixels = mapModule.generateMapWithExplored(map)
    -- print(pixels)
    local x = 0
    local y = 0
    for i = 1, map.width*map.height, 1 do
        if pixels[i] and pixels[i] > 0 then
            x = math.floor(i / map.width)
            y = i % map.width
            gui.drawpixel(x, y, map.colors[map.pixels[i]])
        else
            gui.drawpixel(x, y, "#33663366")
        end
        -- if pixels[i] == 0 then
        --     gui.drawpixel(x, y, "#33663366")
        -- else
        --     gui.drawpixel(x, y, "#CCAAEEFF")
        -- end
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
    displayMap = displayMap,
    logValues = logValues,
}
