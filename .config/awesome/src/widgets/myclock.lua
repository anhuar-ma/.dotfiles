------------------------------
-- This is the clock widget --
------------------------------

-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
require("src.core.signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "src/assets/icons/clock/"

-- Returns the clock widget
return function()

  local clock_widget = wibox.widget {
    {
      {
        {
          id = "label",
          align = "center",
          valign = "center",
          format = "%H:%M:%S",
          refresh = 1,
          widget = wibox.widget.textclock
        },
        id = "clock_layout",
        layout = wibox.layout.fixed.horizontal
      },
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin
    },
   -- bg = color["Orange200"],
    fg = color["White"],
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 7)
    end,
    widget = wibox.container.background
  }

  Hover_signal(clock_widget, color["Orange200"], color["Grey900"])

  return clock_widget
end
