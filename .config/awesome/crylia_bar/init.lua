--------------------------------------------------------------------------------------------------------------
-- This is the statusbar, every widget, module and so on is combined to all the stuff you see on the screen --
--------------------------------------------------------------------------------------------------------------
-- Awesome Libs
local awful = require("awful")
local wibox = require("wibox")



mytextclock = wibox.widget.textclock()

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
                fg = "#FFFFFF",
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
        return #t:clients() > 0
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

  s.battery = require("src.widgets.battery")()
    -- @DOC_WIBAR@
    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        bg = "#11112D", -- Set the background color to red
        -- @DOC_SETUP_WIDGETS@
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
               -- s.mylayoutbox,
                s.mytaglist,
            },
            { -- Middle widget (empty space)
            layout  = wibox.layout.fixed.horizontal,
            spacing = 1,  -- Adjust the spacing as needed
            wibox.widget.textbox(' '), -- This is an empty space
        },
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                s.battery,
                mytextclock,
            },
        }
    }
end)



awful.spawn.with_shell("~/.config/awesome/src/scripts/autostart_once.sh")
