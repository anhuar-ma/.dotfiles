--------------------------------------------------------------------------------------------------------------
-- This is the statusbar, every widget, module and so on is combined to all the stuff you see on the screen --
--------------------------------------------------------------------------------------------------------------
-- Awesome Libs
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi




awful.screen.connect_for_each_screen(
-- For each screen this function is called once
-- If you want to change the modules per screen use the indices
-- e.g. 1 would be the primary screen and 2 the secondary screen.
  function(s)
  -- Create 9 tags
  awful.layout.layouts = user_vars.layouts
  awful.tag(
    { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10","11", "12" , "13", "14", "15", "16", "17", "18", "19", "20"},
    s,
    user_vars.layouts[1]
  )
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
                fg = "#ff59af",
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }


-- Create a taglist widget
s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = function(t, args)
        return #t:clients() > 0 or t.selected
    end,
    buttons = {
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
    }
}

    -- @TASKLIST_BUTTON@
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

  require("src.modules.powermenu")(s)
  -- TODO: rewrite calendar osd, maybe write an own inplementation
  -- require("src.modules.calendar_osd")(s)
  require("src.modules.volume_osd")(s)
  require("src.modules.brightness_osd")(s)
  require("src.modules.titlebar")
  require("src.modules.volume_controller")(s)


  s.taglist = require("src.widgets.mytaglist")(s)
  s.tasklist = require("src.widgets.mytasklist")(s)
  s.ram_info = require("src.widgets.myram_info")()
  s.audio = require("src.widgets.myaudio")(s)
  s.battery = require("src.widgets.mybattery")()
  s.date = require("src.widgets.mydate")()
  s.clock = require("src.widgets.myclock")()  
  s.systray = require("src.widgets.mysystray")()  
  -- @DOC_WIBAR@
    -- Create the wibox
    --
    --
    if s.index == 1 then
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        bg = "#00",
        border_width = 0,
        type = "dock",
        -- @DOC_SETUP_WIDGETS@

widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.align.horizontal, -- Center horizontally
            wibox.widget.textbox(' ', dpi(5)),
            s.taglist,
        },
        { -- Center widget (tasklist)
            layout = wibox.layout.align.horizontal, -- Center horizontally
            expand = "none", -- Do not expand the center widget
            nil, -- Left flexible space
            s.tasklist,
            nil, -- More right flexible space
        },
            {
                layout = wibox.layout.fixed.horizontal,
                --wibox.widget.systray(),
                s.systray,
                wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                s.audio,
                wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                s.battery,
                wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                s.ram_info,
                wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                s.date,
                wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                s.clock,
                wibox.widget.textbox(' ', dpi(5)),
            },
    }
}

else
 s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        bg = "#00",
        border_width = 0,
        type = "dock",
        -- @DOC_SETUP_WIDGETS@

widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.align.horizontal, -- Center horizontally
            wibox.widget.textbox(' ', dpi(5)),
            s.taglist,
        },
        { -- Center widget (tasklist)
            layout = wibox.layout.align.horizontal, -- Center horizontally
            expand = "none", -- Do not expand the center widget
            nil, -- Left flexible space
            s.tasklist,
            nil, -- More right flexible space
        },
            {
                layout = wibox.layout.fixed.horizontal,
                --wibox.widget.systray(),
                --s.systray,
                --wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                --s.audio,
                --wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                s.ram_info,
                wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                --s.battery,
                --wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                s.date,
                wibox.container.margin(nil, 5, 0, 0, 0), -- Spacer with 5px on left and right
                s.clock,
                wibox.widget.textbox(' ', dpi(5)),
            },
    }
}
end

    
end)



awful.spawn.with_shell("~/.config/awesome/src/scripts/autostart.sh")
