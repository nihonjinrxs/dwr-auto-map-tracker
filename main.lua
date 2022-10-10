_G.DWRAutoMapTracker = {}

-- Set the speed of the emulator
emu.speedmode("normal")

local game = require "game"
local data = require "data"
local display = require "display"
-- local tracker_gui = require "tracker_gui"
DWRAutoMapTracker.AllData = data.Data

-- Declare variables to track
DWRAutoMapTracker.Trackables = game.Trackables
DWRAutoMapTracker.TrackedValues = {}

-- tracker_gui.initUI(DWRAutoMapTracker.TrackedValues)

-- Start emulator loop
while true do
    game.updateTracked(DWRAutoMapTracker.Trackables, DWRAutoMapTracker.TrackedValues)
    data.updateData(DWRAutoMapTracker.TrackedValues, DWRAutoMapTracker.AllData)
    display.displayOSD(DWRAutoMapTracker.AllData)
    display.displayMap(DWRAutoMapTracker.AllData.map)
    -- tracker_gui.updateUI(dataTable)

    emu.frameadvance()
end
