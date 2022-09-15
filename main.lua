_G.DWRAutoMapTracker = {}

-- Set the speed of the emulator
emu.speedmode("normal")

local game = require "game"
local parsers = require "parsers"
local display = require "display"
-- local tracker_gui = require "tracker_gui"

-- Declare variables to track
DWRAutoMapTracker.Trackables = game.Trackables
DWRAutoMapTracker.TrackedValues = {}

-- DWRAutoMapTracker.UI = tracker_gui.initUI()

-- Start emulator loop
while true do
    game.updateTracked(DWRAutoMapTracker.Trackables, DWRAutoMapTracker.TrackedValues)
    parsers.parseAll(DWRAutoMapTracker.TrackedValues)
    display.displayOSD(DWRAutoMapTracker.TrackedValues)
    -- display.logValues(DWRAutoMapTracker.TrackedValues)

    emu.frameadvance()
end
