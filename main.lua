_G.DWRAutoMapTracker = {}

-- Set the speed of the emulator
emu.speedmode("normal")

local game = require "game"
local data = require "data"
local display = require "display"
-- local tracker_gui = require "tracker_gui"

-- Declare variables to track
DWRAutoMapTracker.Trackables = game.Trackables
DWRAutoMapTracker.TrackedValues = {}

-- DWRAutoMapTracker.UI = tracker_gui.initUI()

-- Start emulator loop
local dataTable = data.Data
while true do
    game.updateTracked(DWRAutoMapTracker.Trackables, DWRAutoMapTracker.TrackedValues)
    data.updateData(DWRAutoMapTracker.TrackedValues, dataTable)
    display.displayOSD(dataTable)
    -- display.logValues(dataTable)

    emu.frameadvance()
end
