_G.DWRAutoMapTracker = {}

-- Set the speed of the emulator
emu.speedmode("normal")

local parsers = require "parsers"
local display = require "display"
-- local tracker_gui = require "tracker_gui"

-- Declare variables to track
DWRAutoMapTracker.Trackables = {
    playerX = { label = "Player X", address = 0x3A, size = 8 },
    playerY = { label = "Player Y", address = 0x3B, size = 8 },
    playerV = { label = "Player V", address = 0x3E, size = 8 },
    playerH = { label = "Player H", address = 0x42, size = 8 },
    map = { label = "Map", address = 0x45, size = 8 },
    rngState = { label = "RNG State", address = 0x94, size = 16 },
    xp = { label = "XP", address = 0xBA, size = 16 },
    gold = { label = "Gold", address = 0xBC, size = 16 },
    keys = { label = "Keys", address = 0xBF, size = 8 },
    hp = { label = "HP", address = 0xC5, size = 8 },
    hpMax = { label = "Max HP", address = 0xCA, size = 8 },
    mp = { label = "MP", address = 0xC6, size = 8 },
    mpMax = { label = "Max MP", address = 0xCB, size = 8 },
    level = { label = "Level", address = 0xC7, size = 8 },
    strength = { label = "Strength", address = 0xC8, size = 8 },
    agility = { label = "Agility", address = 0xC9, size = 8 },
    ap = { label = "AP", address = 0xCC, size = 8 },
    dp = { label = "DP", address = 0xCD, size = 8 },
}
DWRAutoMapTracker.TrackedValues = {}

-- DWRAutoMapTracker.UI = tracker_gui.initUI()

-- Functions for updating memory state
local function readTrackableFromMemory(trackable)
    if (trackable.size == 8) then 
        return {
            label = trackable.label,
            memValue = memory.readbyte(trackable.address)
        }
    elseif (trackable.size == 16) then
        return {
            label = trackable.label,
            memValue = memory.readword(trackable.address)
        }
    end
end

local function updateTracked()
    for key,value in pairs(DWRAutoMapTracker.Trackables) do
        DWRAutoMapTracker.TrackedValues[key] = readTrackableFromMemory(value)
    end
end

-- Start emulator loop
while true do
    updateTracked()
    parsers.parseAll(DWRAutoMapTracker.TrackedValues)
    display.displayOSD(DWRAutoMapTracker.TrackedValues)
    -- display.logValues(DWRAutoMapTracker.TrackedValues)

    emu.frameadvance()
end
