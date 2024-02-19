-----------------------------
-- This is the date widget --
-----------------------------

-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
require("src.core.signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "src/assets/icons/date/"

-- Returns the date widget
return function()

  local date_widget = wibox.widget {
    {
      {
        {
          id = "label",
          align = "center",
          valign = "center",
          widget = wibox.widget.textbox
        },
        id = "date_layout",
        layout = wibox.layout.fixed.horizontal
      },
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin
    },
  --  bg = color["Teal200"],
    fg = color["White"],
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 7)
    end,
    widget = wibox.container.background
  }

  local set_date = function()
    date_widget.container.date_layout.label:set_text(os.date("%a, %d %b"))
  end

  -- Updates the date every minute, dont blame me if you miss silvester
  gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = function()
      set_date()
    end
  }

  -- Signals
  Hover_signal(date_widget, color["Teal200"], color["Grey900"])

  date_widget:connect_signal(
    "mouse::enter",
    function()
      awesome.emit_signal("widget::calendar_osd:stop", true)
    end
  )

  date_widget:connect_signal(
    "mouse::leave",
    function()
      awesome.emit_signal("widget::calendar_osd:rerun", true)
    end
  )

  return date_widget
end
