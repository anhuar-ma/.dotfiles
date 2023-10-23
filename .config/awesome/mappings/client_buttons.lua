-- Awesome Libs
local awful = require("awful")
local gears = require("gears")

local modkey = user_vars.modkey

return gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end),

    -- Enable sloppy focus, so that focus follows mouse.
   -- client.connect_signal("mouse::enter", function(c)
     --   c:activate { context = "mouse_enter", raise = false }
    --end),
    client.connect_signal("mouse::move", function(c)
        c:activate { context = "mouse_enter", raise = false }
    end)
)
