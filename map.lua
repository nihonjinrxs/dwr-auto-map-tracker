local lookups = require 'lookups'

local function coordsToPixelIndex(width, x, y)
    return ((width or 120) * y) + x + 1
end

local function readRLEMapPixels(width, height)
    local totalPixels = (width or 120) * (height or 120)
    local pixels = {}
    local currentAddr = 0x1A56
    local currentByte = 0x00
    local tile = 0x0
    local count = 0x0
    local i = 1
    local k = 1

    print("Reading map from ROM...")
    while i < totalPixels do
        currentByte = rom.readbyte(currentAddr)
        tile = bit.rshift(currentByte, 4)
        count = bit.band(currentByte, 0xF)
        for k = 1, count, 1 do
            pixels[i] = lookups.overworldTilePixelValues[lookups.overworldTiles[tile]]
            i = i + 1
        end
        currentAddr = currentAddr + 0x1
    end

    print(pixels)
    print("Completed reading map from ROM.")
    return pixels
end

local function generateMapData(width, height)
    return {
        width = width,
        height = height,
        pixels = readRLEMapPixels(width, height),
        colors = lookups.overworldPixelColorMapping,
    }
end

local function generateMapExplored(width, height)
    local explored = {}
    for i = 1, width * height, 1 do
        explored[i] = 0
    end
    return explored
end

local data = generateMapData(
    (_G.DWRAutoMapTracker.AllData and _G.DWRAutoMapTracker.AllData.map.width) or 120,
    (_G.DWRAutoMapTracker.AllData and _G.DWRAutoMapTracker.AllData.map.height) or 120
)
local explored = generateMapExplored(
    (_G.DWRAutoMapTracker.AllData and _G.DWRAutoMapTracker.AllData.map.width) or 120,
    (_G.DWRAutoMapTracker.AllData and _G.DWRAutoMapTracker.AllData.map.height) or 120
)

local function updateMapExplored(AllData)
    -- print(AllData.player, AllData.map.width, AllData.map.height)
    if AllData.player and AllData.map.explored then
        local left = math.max(AllData.player.position.x - 7, 0)
        local right = math.min(AllData.player.position.x + 7, AllData.map.width or 120)
        local top = math.max(AllData.player.position.y - 7, 0)
        local bottom = math.min(AllData.player.position.y + 7, AllData.map.height or 120)
        -- print(string.format(
        --     "upd expl: p(%d,%d), >(%d,%d), v(%d,%d)",
        --     AllData.player.position.x, AllData.player.position.y, left, right, top, bottom
        -- ))
        local i = 0
        for x = left,right,1 do
            for y = top,bottom,1 do
                i = coordsToPixelIndex(AllData.map.width, x, y)
                -- print(string.format("(%d,%d) -> %d", x, y, i))
                AllData.map.explored[i] = 1
            end
        end
        -- print(AllData.map.explored)
        return AllData.map.explored
    else
        return generateMapExplored(AllData.map.width, AllData.map.height)
    end
end

local function generateMapWithExplored()
    local width = _G.DWRAutoMapTracker.AllData.map.data.width or 120
    local height = _G.DWRAutoMapTracker.AllData.map.data.height or 120
    local displayMap = {
        width = width,
        height = height,
        pixels = {},
        colors = _G.DWRAutoMapTracker.AllData.map.data.colors,
    }

    local mapPixels = _G.DWRAutoMapTracker.AllData.map.data.pixels
    local explored = _G.DWRAutoMapTracker.AllData.map.explored
    for i = 1, width * height, 1 do
        displayMap.pixels[i] = (mapPixels[i] or 4) * (explored[i] or 0)
    end
    return displayMap
end

return {
    data = data,
    height = (_G.DWRAutoMapTracker.AllData and _G.DWRAutoMapTracker.AllData.map.data.height) or 120,
    width = (_G.DWRAutoMapTracker.AllData and _G.DWRAutoMapTracker.AllData.map.data.width) or 120,
    explored = explored,
    updateMapExplored = updateMapExplored,
    generateMapWithExplored = generateMapWithExplored,
}
