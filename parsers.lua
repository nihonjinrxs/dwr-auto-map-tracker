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
        print("Items byte "..i.." nybbles are {"..nybbles[1]..","..nybbles[2].."}")
        for _n,key in ipairs(nybbles) do
            if key > 0 then
                table.insert(items, lookups.items[key])
            end
        end
    end
    return items
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
        print("parsing items... found"..#(TrackedValues.items.parsedValue).." items")
    end
end

return {
    parseAll = parseAll,
    -- noParse = noParse,
    -- parseMap = parseMap,
    -- parseWithMax = parseWithMax,
}
