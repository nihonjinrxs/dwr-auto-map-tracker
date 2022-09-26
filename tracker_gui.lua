require 'auxlib'

local map = require 'map'

function initUI()
    local mapImage = iup.image(map.data)

	dialogs = dialogs + 1; -- there is no ++ in Lua
	handles[dialogs] = 
		iup.dialog{
			title="Dragon Warrior Randomizer Auto-Tracker",
            iup.vbox{
                iup.hbox{
                    iup.frame{
                        title="Map",
                        iup.canvas{bgcolor="128 255 0", image=mapImage},                        
                    }, -- /frame
                }, -- /hbox
                iup.frame{
                    title="IupLabel",
                    iup.vbox{
                        iup.label{title="Label Text"},
                        iup.label{title="",separator="HORIZONTAL"},
                        iup.label{title="",image=img1}
                    } -- /vbox
                }, -- /frame
                iup.frame{
                    title="IupToggle",
                    iup.vbox{
                        iup.toggle{title="Toggle Text", value="ON"},
                        iup.toggle{title="",image=img1,impress=img2},
                        iup.frame{
                            title="IupRadio",
                            iup.radio{
                                iup.vbox{
                                    iup.toggle{title="Toggle Text"},
                                    iup.toggle{title="Toggle Text"}
                                } -- /vbox
                            } -- /radio
                        } -- /frame
                    } -- /vbox
                }, -- /frame
                iup.frame{
                    title="IupText/IupMultiline",
                    iup.vbox{
                        iup.text{size="80x",value="IupText Text"},
                        iup.multiline{size="80x60",
                        expand="YES",
                        value="IupMultiline Text\nSecond Line\nThird Line"}
                    } -- /vbox
                }, -- /frame
                iup.frame{
                    title="IupList",
                    iup.vbox{
                        iup.list{"Item 1 Text","Item 2 Text","Item 3 Text"; expand="YES",value="1"},
                        iup.list{"Item 1 Text","Item 2 Text","Item 3 Text"; dropdown="YES",expand="YES",value="2"},
                        iup.list{"Item 1 Text","Item 2 Text","Item 3 Text"; editbox="YES",expand="YES",value="3"}
                    } -- /vbox
                } -- frame
            }, -- /vbox
            gap="5",
            alignment="ARIGHT",
            margin="5x5"
        } -- /dialog

    -- this actually shows you the dialog. Note that this is equivalent to calling handles[dialogs].show(handles[dialogs]); just shorter.
	handles[dialogs]:show();
end

return {
    initUI = initUI
}
