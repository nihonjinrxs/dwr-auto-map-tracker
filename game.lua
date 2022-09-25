local utils = require("utils")
local read_ui16 = utils.read_ui16
-- local map = require("map")

local Trackables = {
    playerX = { label = "Player X", address = 0x3A, bytes = 1 },
    playerY = { label = "Player Y", address = 0x3B, bytes = 1 },
    playerV = { label = "Player V", address = 0x3E, bytes = 1 },
    playerH = { label = "Player H", address = 0x42, bytes = 1 },
    map = { label = "Map", address = 0x45, bytes = 1 },
    maxX = { label = "Map X", address = 0x8E, bytes = 1 },
    maxY = { label = "Map Y", address = 0x8F, bytes = 1 },
    rngState = { label = "RNG State", address = 0x94, bytes = 2 },
    xp = { label = "XP", address = 0xBA, bytes = 2 },
    gold = { label = "Gold", address = 0xBC, bytes = 2 },
    keys = { label = "Keys", address = 0xBF, bytes = 1 },
    herbs = { label = "Herbs", address = "0xC0", bytes = 1 },
    hp = { label = "HP", address = 0xC5, bytes = 1 },
    hpMax = { label = "Max HP", address = 0xCA, bytes = 1 },
    mp = { label = "MP", address = 0xC6, bytes = 1 },
    mpMax = { label = "Max MP", address = 0xCB, bytes = 1 },
    level = { label = "Level", address = 0xC7, bytes = 1 },
    strength = { label = "Strength", address = 0xC8, bytes = 1 },
    agility = { label = "Agility", address = 0xC9, bytes = 1 },
    ap = { label = "AP", address = 0xCC, bytes = 1 },
    dp = { label = "DP", address = 0xCD, bytes = 1 },
    tileset = { label = "tile set", address = 0x16, bytes = 1 },
    items = { label = "Items", address = 0x00C1, bytes = 4 },
    spells = { label = "Spells", address = 0x00CE, bytes = 1 },
    quest = { label = "Quest Progress", address = 0x00CF, bytes = 1 },
    quest2 = { label = "- not displayed -", address = 0x00DF, bytes = 1 },
    quest3 = { label = "- not displayed -", address = 0x00E4, bytes = 1 },
    equipment = { label = "Equipment", address = 0x00BE, bytes = 1 },
}

-- Screen is 0-255 in X, 0-239 in Y, but NTSC only displays 8-231 of Y
local screenMinX = 0
local screenMinY = 8
local screenMaxX = 255
local screenMaxY = 231

local function getROMInfo()
    return {
        filename = rom.getfilename(),
        hash = rom.gethash("md5")
    }
end

-- Functions for updating memory state
local function readTrackableFromMemory(trackable)
    if (trackable.bytes == 1) then 
        return {
            label = trackable.label,
            memValue = memory.readbyte(trackable.address)
        }
    elseif (trackable.bytes == 2) then
        return {
            label = trackable.label,
            memValue = memory.readword(trackable.address)
        }
    else
        return {
            label = trackable.label,
            memValue = memory.readbyterange(trackable.address, trackable.bytes)
        }
    end
end

local function updateTracked(Trackables, TrackedValues)
    for key,value in pairs(Trackables) do
        TrackedValues[key] = readTrackableFromMemory(value)
    end
end


return {
    Trackables = Trackables,
    updateTracked = updateTracked,
    screenDimensions = {
        minX = screenMinX,
        maxX = screenMaxX,
        minY = screenMinY,
        maxY = screenMaxY
    },
    getROMInfo = getROMInfo
}
