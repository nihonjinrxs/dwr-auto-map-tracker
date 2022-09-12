-- Load the wxLua module, does nothing if running from wxLua, wxLuaFreeze, or wxLuaEdit
package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx") -- populates the wx global

local frame = nil

local function onPaint()
end

local function createChildPanel(frame)
    -- create a single child window, wxWidgets will set the size to fill frame
    local panel = wx.wxScrolledWindow(frame, wx.wxID_ANY)
    panel:SetScrollbars(200, 200, 20, 20, 0, 0, true);

    -- connect the paint event handler function with the paint event
    panel:Connect(wx.wxEVT_PAINT, onPaint)
end

local function createMenu(frame)
    -- create a simple file menu
    local fileMenu = wx.wxMenu()
    fileMenu:Append(wx.wxID_EXIT, "E&xit", "Quit the program")
    -- create a simple help menu
    local helpMenu = wx.wxMenu()
    helpMenu:Append(wx.wxID_ABOUT, "&About", "About the wxLua Minimal Application")

    -- create a menu bar and append the file and help menus
    local menuBar = wx.wxMenuBar()
    menuBar:Append(fileMenu, "&File")
    menuBar:Append(helpMenu, "&Help")

    -- attach the menu bar into the frame
    frame:SetMenuBar(menuBar)

    -- connect the selection event of the exit menu item to an
    -- event handler that closes the window
    frame:Connect(
        wx.wxID_EXIT,
        wx.wxEVT_COMMAND_MENU_SELECTED,
        function (event) frame:Close(true) end
    )

    -- connect the selection event of the about menu item
    frame:Connect(
        wx.wxID_ABOUT,
        wx.wxEVT_COMMAND_MENU_SELECTED,
        function (event)
            wx.wxMessageBox(
                'This DWR Auto Map Tracker was created by CodeAndData.\n'..
                    wxlua.wxLUA_VERSION_STRING.." built with "..wx.wxVERSION_STRING,
                    "About wxLua",
                wx.wxOK + wx.wxICON_INFORMATION,
                frame
            )
        end
    )
end

local function createStatusBar(frame)
    -- create a simple status bar
    frame:CreateStatusBar(1)
    frame:SetStatusText("Starting.")
end    

local function initUI()
    -- create the wxFrame window
    frame = wx.wxFrame(
        wx.NULL,                    -- no parent for toplevel windows
        wx.wxID_ANY,                -- don't need a wxWindow ID
        "DWR Auto Map Tracker",     -- caption on the frame
        wx.wxDefaultPosition,       -- let system place the frame
        wx.wxSize(400, 600),        -- set the size of the frame
        wx.wxDEFAULT_FRAME_STYLE )  -- use default frame styles

    createChildPanel(frame)
    createMenu(frame)
    createStatusBar(frame)

    -- show the frame window
    frame:Show(true)
end

return {
    mainWindow = frame,
    initUI = initUI,
}
