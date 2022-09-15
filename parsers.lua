local lookups = require "lookups"

local function parseMap(mapByte)
    return lookups.maps[mapByte]
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
    return {
        weapon = valueByte and lookups.weapons[bit.band(224, valueByte)] or nil,
        armor = valueByte and lookups.armor[bit.band(28, valueByte)] or nil,
        shield = valueByte and lookups.shields[bit.band(3, valueByte)] or nil,
    }
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

local function parseAllItems(itemBytes, keysByte)
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

local function parseQuestItems(itemBytes)
    local all_items = parseAllItems(itemBytes, 0)
    return all_items.items
end

local function parseItems(itemBytes, keysByte)
    local all_items = parseAllItems(itemBytes, keysByte)
    return all_items.quest_items
end

local function parseSpells(byte1, byte2)
    return {
        HEAL = byte1 and bit.band(0x01, byte1) > 0 or false,
        HURT = byte1 and bit.band(0x02, byte1) > 0 or false,
        SLEEP = byte1 and bit.band(0x04, byte1) > 0 or false,
        RADIANT = byte1 and bit.band(0x08, byte1) > 0 or false,
        STOPSPELL = byte1 and bit.band(0x10, byte1) > 0 or false,
        OUTSIDE = byte1 and bit.band(0x20, byte1) > 0 or false,
        RETURN = byte1 and bit.band(0x40, byte1) > 0 or false,
        REPEL = byte1 and bit.band(0x80, byte1) > 0 or false,
        HEALMORE = byte2 and bit.band(0x01, byte2) > 0 or false,
        HURTMORE = byte2 and bit.band(0x02, byte2) > 0 or false,
    }
end

local function parseEquipped(byteValue)
    return {
        dragon_scale = byteValue and bit.band(16, byteValue) > 0 or false,
        figher_ring = byteValue and bit.band(32, byteValue) > 0 or false,
        cursed_belt = byteValue and bit.band(64, byteValue) > 0 or false,
        death_necklace = byteValue and bit.band(128, byteValue) > 0 or false,
    }
end

local function parseQuestProgress(questByte1, questByte2, questByte3)
    return {
        left_throne_room = questByte2 and bit.band(8, questByte2) > 0 or false,
        green_dragon_trap = questByte3 and bit.band(2, questByte3) > 0 or false,
        golem_trap = questByte3 and bit.band(2, questByte3) > 0 or false,
        princess_rescued = questByte2 and bit.band(1, questByte2) > 0 or false,
        princess_returned = questByte2 and bit.band(2, questByte2) > 0 or false,
        rainbow_bridge = questByte1 and bit.band(8, questByte1) > 0 or false,
        charlock_stairs = questByte1 and bit.band(4, questByte1) > 0 or false,
        defeated_dragonlord = questByte3 and bit.band(64, questByte3) > 0 or false
    }
end

return {
    parseMap = parseMap,
    parseStats = parseStats,
    parseEquipped = parseEquipped,
    parseEquipment = parseEquipment,
    parseQuestProgress = parseQuestProgress,
    parseQuestItems = parseQuestItems,
    parseItems = parseItems,
    parseSpells = parseSpells,
}
