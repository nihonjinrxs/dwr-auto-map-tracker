local function generatePrintables(TrackedValues)
    local printables = {
        "ROM Name: "..rom.getfilename(),
        "ROM Hash: "..rom.gethash("md5"),
    }
    if TrackedValues.map.parsedValue and TrackedValues.map.parsedValue == "None" then
        return printables
    end
    local orderedKeys = {
        "map", "level", "xp", "hp", "mp",
        "strength", "agility", "ap", "dp",
        "gold", "keys", "equipment",
        "items", "spells", "quest",
    }
    for i, key in ipairs(orderedKeys) do
        local value = TrackedValues[key]
        print(value.label.." type: "..(type(value.parsedValue)).." value: "..tostring(value.parsedValue))
        if value.parsedValue then
            if type(value.parsedValue) == "string" or type(value.parsedValue) == "number" then
                table.insert(printables, value.label..": "..value.parsedValue)
            elseif type(value.parsedValue) == "table" then
                table.insert(printables, value.label..":")
                print(value.label..":")
                for i,val in ipairs(value.parsedValue) do
                    print("  - "..val)
                    table.insert(printables, "  - "..val)
                end
            end
        end
    end
    return printables
end

local function displayOSD(TrackedValues)
    print("")
    print("")
    local printables = generatePrintables(TrackedValues)
    local textX = 0
    local textY = 10
    local printablesCount = #(printables)
    for i = 1,printablesCount do
        gui.text(textX, textY, printables[i])
        textY = textY + 10
    end
end

local function logValues(TrackedValues)
    local valuesCount = #(TrackedValues)
    print("Found "..valuesCount.." tracked values:")
    for _key,value in pairs(TrackedValues) do
        if value.memValue then
            print("  "..value.label..": "..value.memValue)
        end
    end
end

return {
    displayOSD = displayOSD,
    logValues = logValues,
}
