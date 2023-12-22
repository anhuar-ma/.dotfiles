-- Awesome Libs
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local ruled = require("ruled")

local modkey = user_vars.modkey
-- Variable to keep track of the current layout
local current_layout = awful.layout.suit.tile
-- Function to toggle between max and tile layouts
local function toggle_layout()
    if current_layout == awful.layout.suit.tile then
        awful.layout.set(awful.layout.suit.max)
        current_layout = awful.layout.suit.max
    else
        awful.layout.set(awful.layout.suit.tile)
        current_layout = awful.layout.suit.tile
    end
end
return gears.table.join(

awful.key({ modkey }, "b",
          function ()
              myscreen = awful.screen.focused()
              myscreen.mywibox.visible = not myscreen.mywibox.visible
          end,
          {description = "toggle statusbar"}
),



-- Keybinding to toggle layouts (Super + t in this example)
awful.key({ modkey }, "", toggle_layout, {description = "Toggle layout", group = "Layout"}),


  awful.key(
    { modkey },
    "",
    hotkeys_popup.show_help,
    { description = "Cheat sheet", group = "Awesome" }
  ),
  -- Tag browsing
  awful.key(
    { modkey },
    "#113",
    awful.tag.viewprev,
    { description = "View previous tag", group = "Tag" }
  ),
  awful.key(
    { modkey },
    "#114",
    awful.tag.viewnext,
    { description = "View next tag", group = "Tag" }
  ),
  awful.key(
    { modkey },
    "#66",
    awful.tag.history.restore,
    { description = "Go back to last tag", group = "Tag" }
  ),
  awful.key(
    { modkey },
    "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "Focus next client by index", group = "Client" }
  ),
  awful.key(
    { modkey },
    "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "Focus previous client by index", group = "Client" }
  ),
  awful.key(
    { modkey, "Shift" },
    "j",
    function()
      awful.client.swap.byidx(1)
    end,
    { description = "Swap with next client by index", group = "Client" }
  ),
  awful.key(
    { modkey, "Shift" },
    "k",
    function()
      awful.client.swap.byidx(-1)
    end,
    { description = "Swap with previous client by index", group = "Client" }
  ),
  awful.key(
    { modkey, "Control" },
    "j",
    function()
      awful.screen.focus_relative(1)
    end,
    { description = "Focus the next screen", group = "Screen" }
  ),
  awful.key(
    { modkey, "Control" },
    "k",
    function()
      awful.screen.focus_relative(-1)
    end,
    { description = "Focus the previous screen", group = "Screen" }
  ),
  awful.key(
    { modkey },
    "u",
    awful.client.urgent.jumpto,
    { description = "Jump to urgent client", group = "Client" }
  ),
  awful.key(
    { modkey },
    "Return",
    function()
      awful.spawn(user_vars.terminal)
    end,
    { description = "Open terminal", group = "Applications" }
  ),
  awful.key(
    { modkey, "Control" },
    "r",
    awesome.restart,
    { description = "Reload awesome", group = "Awesome" }
  ),
  awful.key(
    { modkey },
    "l",
    function()
      awful.tag.incmwfact(0.05)
    end,
    { description = "Increase client width", group = "Layout" }
  ),
  awful.key(
    { modkey },
    "h",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    { description = "Decrease client width", group = "Layout" }
  ),
  awful.key(
    { modkey, "Control" },
    "h",
    function()
      awful.tag.incncol(1, nil, true)
    end,
    { description = "Increase the number of columns", group = "Layout" }
  ),
  awful.key(
    { modkey, "Control" },
    "l",
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    { description = "Decrease the number of columns", group = "Layout" }
  ),
  awful.key(
    { modkey, "Shift"},
    "space",
    function()
      awful.layout.inc(1)
    end,
    { description = "Select previous layout", group = "Layout" }
  ),
  awful.key(
    { modkey},
    "",
    function()
      awful.layout.inc(-1)
    end,
    { description = "Select next layout", group = "Layout" }
  ),

 awful.key(
    { modkey },
    "s",
    function()
      awful.spawn("brave")
    end,
    { descripton = "Application launcher", group = "Application" }
  ),

   awful.key(
    { modkey },
    "r",
    function()
      awful.spawn("rofi -show drun")
    end,
    { descripton = "Application launcher", group = "Application" }
  ),

   awful.key(
    { modkey, "Shift"},
    "r",
    function()
      awful.spawn("rofi -show run")
    end,
    { descripton = "run a command on rofi", group = "Application" }
  ),
  awful.key(
    { "Mod1" },
    "Tab",
    function()
      awful.spawn("rofi -show windowcd")
    end,
    { descripton = "Client switcher (alt+tab)", group = "Application" }
  ),

  awful.key(
    { "Mod1","Shift" },
    "Tab",
    function()
      awful.spawn("rofi -show window")
    end,
    { descripton = "Client switcher (alt+tab)", group = "Application" }
  ),

  awful.key(
    { "Mod1" },
    "",
    function()
      awful.spawn("rofi -show windowcd -theme ~/.config/rofi/window.rasi")
    end,
    { descripton = "Client switcher (alt+tab)", group = "Application" }
  ),
awful.key(
    { modkey },
    "e",
    function()
      awful.spawn("emacs")
    end,
    { descripton = "Open file manager", group = "System" }
  ),

 awful.key(
    { modkey },
    "t",
    function()
      awful.spawn(user_vars.file_manager)
    end,
    { descripton = "Open file manager", group = "System" }
  ),
  awful.key(
    { modkey, "Shift" },
    "#26",
    function()
      awesome.emit_signal("module::powermenu:show")
    end,
    { descripton = "Session options", group = "System" }
  ),
  awful.key(
    { modkey, "Shift" },
    "s",
    function()
      awful.spawn(user_vars.screenshot_program)
    end,
    { description = "Screenshot", group = "Applications" }
  ),
  awful.key(
    {},
    "XF86AudioLowerVolume",
    function(c)
      awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -2%", function()
        awesome.emit_signal("module::volume_osd:show", true)
        awesome.emit_signal("module::slider:update")
        awesome.emit_signal("widget::volume_osd:rerun")
      end)
    end,
    { description = "Lower volume", group = "System" }
  ),
  awful.key(
    {},
    "XF86AudioRaiseVolume",
    function(c)
      awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +2%", function()
        awesome.emit_signal("module::volume_osd:show", true)
        awesome.emit_signal("module::slider:update")
        awesome.emit_signal("widget::volume_osd:rerun")
      end)
    end,
    { description = "Increase volume", group = "System" }
  ),
  awful.key(
    {},
    "XF86AudioMute",
    function(c)
      awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
      awesome.emit_signal("module::volume_osd:show", true)
      awesome.emit_signal("module::slider:update")
      awesome.emit_signal("widget::volume_osd:rerun")
    end,
    { description = "Mute volume", group = "System" }
  ),
  awful.key(
    {},
    "XF86MonBrightnessUp",
    function(c)
      --awful.spawn("xbacklight -time 100 -inc 10%+")
      awful.spawn.easy_async_with_shell(
        "pkexec xfpm-power-backlight-helper --get-brightness",
        function(stdout)
          awful.spawn.easy_async_with_shell("pkexec xfpm-power-backlight-helper --set-brightness " .. tostring(tonumber(stdout) +  2 * BACKLIGHT_SEPS), function(stdou2)

          end)
          awesome.emit_signal("module::brightness_osd:show", true)
          awesome.emit_signal("module::brightness_slider:update")
          awesome.emit_signal("widget::brightness_osd:rerun")
        end
      )
    end,
    { description = "Raise backlight brightness", group = "System" }
  ),
  awful.key(
    {},
    "XF86MonBrightnessDown",
    function(c)
      awful.spawn.easy_async_with_shell(
        "pkexec xfpm-power-backlight-helper --get-brightness",
        function(stdout)
          awful.spawn.easy_async_with_shell("pkexec xfpm-power-backlight-helper --set-brightness " .. tostring(tonumber(stdout) - 2 * BACKLIGHT_SEPS), function(stdout2)

          end)
          awesome.emit_signal("module::brightness_osd:show", true)
          awesome.emit_signal("module::brightness_slider:update")
          awesome.emit_signal("widget::brightness_osd:rerun")
        end
      )
    end,
    { description = "Lower backlight brightness", group = "System" }
  ),
  awful.key(
    {},
    "XF86AudioPlay",
    function(c)
      awful.spawn("playerctl play-pause")
    end,
    { description = "Play / Pause audio", group = "System" }
  ),
  awful.key(
    {},
    "XF86AudioNext",
    function(c)
      awful.spawn("playerctl next")
    end,
    { description = "Play / Pause audio", group = "System" }
  ),
  awful.key(
    {},
    "XF86AudioPrev",
    function(c)
      awful.spawn("playerctl previous")
    end,
    { description = "Play / Pause audio", group = "System" }
  ),
  awful.key(
    { modkey },
    "#65",
    function()
      awesome.emit_signal("kblayout::toggle")
    end,
    { description = "Toggle keyboard layout", group = "System" }
  ),
  awful.key(
    { modkey },
    "i",
    function()

    end
  ),
  awful.key(
    { modkey, "Shift" },
    "i",
    awful.client.floating.toggle
  )
)
