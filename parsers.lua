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
end

return {
    parseAll = parseAll,
    -- noParse = noParse,
    -- parseMap = parseMap,
    -- parseWithMax = parseWithMax,
}
