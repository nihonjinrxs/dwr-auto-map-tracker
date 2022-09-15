local lookups = require "lookups"

local function noParse(byteValue)
    return byteValue
end

local function parseMap(mapByte)
    return lookups.maps[mapByte]
end

local function parseWithMax(valueByte, maxByte)
    return string.format("%d / %d", valueByte, maxByte)
end

local function parseStats(TrackedValues)
    return {
        xp = TrackedValues.xp.memValue or 0,
        level = TrackedValues.level.memValue or 0,
        hp = TrackedValues.hp.memValue or 0,
        hpMax = TrackedValues.hpMax.memValue or 0,
        mp = TrackedValues.mp.memValue or 0,
        mpMax = TrackedValues.mpMax.memValue or 0,
        strength = TrackedValues.strength.memValue or 0,
        agility = TrackedValues.agility.memValue or 0,
        attack = TrackedValues.ap.memValue or 0,
        defense = TrackedValues.dp.memValue or 0,
    }
end

local function parseEquipment(valueByte)
    local equipment = {
        weapon = nil, armor = nil, shield = nil,
    }
    if (valueByte) then
        equipment.weapon = lookups.weapons[bit.band(224, valueByte)]
        equipment.armor = lookups.armor[bit.band(28, valueByte)]
        equipment.shield = lookups.shields[bit.band(3, valueByte)]
    end

    return equipment
end

local function parseQuestItems(itemBytes)
    local quest_items = {
        dragon_scale = false,
        fighter_ring = false,
        death_necklace = false,
        gwaelin_love = false,
        erdrick_token = false,
        silver_harp = false,
        fairy_flute = false,
        stones_of_sunlight = false,
        staff_of_rain = false,
        rainbow_drop = false,
        ball_of_light = false,
    }

    return quest_items
end

local function getItemsFromBytes(itemBytes)
    local working = {
        herb = 0,
        torch = 0,
        wings = 0,
        fairy_water = 0,
        cursed_belt = 0,
        dragon_scale = 0,
        fighter_ring = 0,
        death_necklace = 0,
        gwaelin_love = 0,
        erdrick_token = 0,
        silver_harp = 0,
        fairy_flute = 0,
        stones_of_sunlight = 0,
        staff_of_rain = 0,
        rainbow_drop = 0,
        ball_of_light = 0,
    }
    if not itemBytes then
        return working
    end

    local nybbles = {0x0, 0x0}
    local currentByte = 0x00
    for i=1,4 do
        currentByte = string.byte(itemBytes, i)
        nybbles = {
            bit.band(0x0F, currentByte),
            bit.rshift(bit.band(0xF0, currentByte), 4),
        }
        for _n,key in ipairs(nybbles) do
            if key > 0 and key < 15 then
                working[lookups.items[key]] = working[lookups.items[key]] + 1
            end
        end
    end

    return working
end

local function parseItems(itemBytes, keysByte)
    local item_set = getItemsFromBytes(itemBytes)
    local quest_items = {
        dragon_scale = item_set.dragon_scale > 0,
        fighter_ring = item_set.fighter_ring > 0,
        death_necklace = item_set.death_necklace > 0,
        gwaelin_love = item_set.gwaelin_love > 0,
        erdrick_token = item_set.erdrick_token > 0,
        silver_harp = item_set.silver_harp > 0,
        fairy_flute = item_set.fairy_flute > 0,
        stones_of_sunlight = item_set.stones_of_sunlight > 0,
        staff_of_rain = item_set.staff_of_rain > 0,
        rainbow_drop = item_set.rainbow_drop > 0,
        ball_of_light = item_set.ball_of_light > 0,
    }
    local items = {
        magic_key = keysByte or 0,
        herb = 0,
        torch = item_set.torch,
        wings = item_set.wings,
        fairy_water = item_set.fairy_water,
        cursed_belt = item_set.cursed_belt,
    }

    return {
        quest_items = quest_items,
        items = items,
    }
end

local function parseSpells(byte1, byte2)
    local spells = {
        HEAL = false,
        HURT = false,
        SLEEP = false,
        RADIANT = false,
        STOPSPELL = false,
        OUTSIDE = false,
        RETURN = false,
        REPEL = false,
        HEALMORE = false,
        HURTMORE = false,
    }
    if byte1 and byte2 then
        spells.HEAL = bit.band(0x01, byte1) > 0
        spells.HURT = bit.band(0x02, byte1) > 0
        spells.SLEEP = bit.band(0x04, byte1) > 0
        spells.RADIANT = bit.band(0x08, byte1) > 0
        spells.STOPSPELL = bit.band(0x10, byte1) > 0
        spells.OUTSIDE = bit.band(0x20, byte1) > 0
        spells.RETURN = bit.band(0x40, byte1) > 0
        spells.REPEL = bit.band(0x80, byte1) > 0
        spells.HEALMORE = bit.band(0x01, byte2) > 0
        spells.HURTMORE = bit.band(0x02, byte2) > 0
    end

    print("Parsed spells: "..tostring(spells))
    return spells
end

local function parseEquipped(byteValue)
    local equipped = {
        dragon_scale = false,
        figher_ring = false,
        cursed_belt = false,
        death_necklace = false,
    }
    if (byteValue) then
        equipped.dragon_scale = bit.band(16, byteValue) > 0
        equipped.fighter_ring =  bit.band(32, byteValue) > 0
        equipped.cursed_belt = bit.band(64, byteValue) > 0
        equipped.death_necklace = bit.band(128, byteValue) > 0
    end
    return equipped
end

local function parseQuestProgress(byte1, byte2, byte3)
    local questProgress = {}

    if bit.band(4, byte1) > 0 then
        table.insert(questProgress, "Charlock Hidden Stairs")
    end
    if bit.band(8, byte1) > 0 then
        table.insert(questProgress, "Rainbow Bridge")
    end
    if bit.band(1, byte2) > 0 then
        table.insert(questProgress, "Rescued Princess")
    end
    if bit.band(2, byte2) > 0 then
        table.insert(questProgress, "Returned Princess")
    end
    if bit.band(8, byte2) > 0 then
        table.insert(questProgress, "Left Throne Room")
    end
    if bit.band(2, byte3) > 0 then
        table.insert(questProgress, "Killed Golem Trap")
    end
    if bit.band(4, byte3) > 0 then
        table.insert(questProgress, "Killed Dragonlord")
    end
    if bit.band(64, byte3) > 0 then
        table.insert(questProgress, "Killed Green Dragon Trap")
    end

    print("Parsed quest progress: "..tostring(questProgress))
    return questProgress
end

local function parseAll(TrackedValues)
    for i,name in ipairs(lookups.nonParseables) do
        if TrackedValues[name].memValue then
            TrackedValues[name].parsedValue = noParse(TrackedValues[name].memValue)
        end
    end
    if TrackedValues.hp.memValue and TrackedValues.hpMax.memValue then
        TrackedValues.hp.parsedValue = parseWithMax(TrackedValues.hp.memValue, TrackedValues.hpMax.memValue)
    end
    if TrackedValues.mp.memValue and TrackedValues.mpMax.memValue then
        TrackedValues.mp.parsedValue = parseWithMax(TrackedValues.mp.memValue, TrackedValues.mpMax.memValue)
    end
    if TrackedValues.map.memValue then
        TrackedValues.map.parsedValue = parseMap(TrackedValues.map.memValue)
    end
    if TrackedValues.items.memValue then
        TrackedValues.items.parsedValue = parseItems(TrackedValues.items.memValue)
    end
    if TrackedValues.spells.memValue and TrackedValues.quest.memValue then
        TrackedValues.spells.parsedValue = parseSpells(TrackedValues.spells.memValue, TrackedValues.quest.memValue)
    end
    if TrackedValues.quest.memValue and TrackedValues.quest2.memValue and TrackedValues.quest3.memValue then
        TrackedValues.quest.parsedValue = parseQuestProgress(
            TrackedValues.quest.memValue,
            TrackedValues.quest2.memValue,
            TrackedValues.quest3.memValue
        )
    end
    if TrackedValues.equipment.memValue then
        TrackedValues.equipment.parsedValue = parseEquipment(TrackedValues.equipment.memValue)
    end
end

return {
    parseStats = parseStats,
    parseEquipped = parseEquipped,
    parseEquipment = parseEquipment,
    parseQuestItems = parseQuestItems,
    parseSpells = parseSpells,
    parseAll = parseAll,
}
