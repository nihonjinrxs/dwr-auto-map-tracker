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

local function parseEquipment(valueByte)
    return {
        lookups.weapons[bit.band(224, valueByte)],
        lookups.armor[bit.band(28, valueByte)],
        lookups.shields[bit.band(3, valueByte)],
    }
end

local function parseItems(valueBytes)
    local items = {}
    local nybbles = {0x0, 0x0}
    local currentByte = 0x00
    for i=1,4 do
        currentByte = string.byte(valueBytes, i)
        nybbles = {
            bit.band(0x0F, currentByte),
            bit.rshift(bit.band(0xF0, currentByte), 4),
        }
        for _n,key in ipairs(nybbles) do
            if key > 0 then
                table.insert(items, lookups.items[key])
            end
        end
    end

    print("Parsed items: "..tostring(items))
    return items
end

local function parseSpells(byte1, byte2)
    local spells = {}
    if bit.band(0x01, byte1) > 0 then
        table.insert(spells, "Heal")
    end
    if bit.band(0x02, byte1) > 0 then
        table.insert(spells, "Hurt")
    end
    if bit.band(0x04, byte1) > 0 then
        table.insert(spells, "Sleep")
    end
    if bit.band(0x08, byte1) > 0 then
        table.insert(spells, "Radiant")
    end
    if bit.band(0x10, byte1) > 0 then
        table.insert(spells, "Stopspell")
    end
    if bit.band(0x20, byte1) > 0 then
        table.insert(spells, "Outside")
    end
    if bit.band(0x40, byte1) > 0 then
        table.insert(spells, "Return")
    end
    if bit.band(0x80, byte1) > 0 then
        table.insert(spells, "Repel")
    end
    if bit.band(0x01, byte2) > 0 then
        table.insert(spells, "Healmore")
    end
    if bit.band(0x02, byte2) > 0 then
        table.insert(spells, "Hurtmore")
    end

    print("Parsed spells: "..tostring(spells))
    return spells
end

local function parseQuestProgress(byte1, byte2, byte3)
    local questProgress = {}

    if bit.band(4, byte1) > 0 then
        table.insert(questProgress, "Charlock Hidden Stairs")
    end
    if bit.band(8, byte1) > 0 then
        table.insert(questProgress, "Rainbow Bridge")
    end
    if bit.band(16, byte1) > 0 then
        table.insert(questProgress, "Dragon Scale Equpped")
    end
    if bit.band(32, byte1) > 0 then
        table.insert(questProgress, "Fighter's Ring Equipped")
    end
    if bit.band(64, byte1) > 0 then
        table.insert(questProgress, "Cursed Belt Equipped")
    end
    if bit.band(128, byte1) > 0 then
        table.insert(questProgress, "Death Necklace Equipped")
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
    parseAll = parseAll,
}
