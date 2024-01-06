------------------------------
-- This is the audio widget --
------------------------------
-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
require("src.core.signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "src/assets/icons/audio/"

-- Returns the audio widget
return function(s)

  local audio_widget = wibox.widget {
    {
      {
        {
          id = "label",
          align = "center",
          valign = "center",
          widget = wibox.widget.textbox
        },
        id = "audio_layout",
        layout = wibox.layout.fixed.horizontal
      },
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin
    },
    --bg = color["Yellow200"],
    fg = color["White"],
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 7)
    end,
    widget = wibox.container.background
  }

  local get_volume = function()
    awful.spawn.easy_async_with_shell(
      "./.config/awesome/src/scripts/vol.sh volume",
      function(stdout)
        local icon = icondir .. "volume"
        stdout = stdout:gsub("%%", "")
        local volume = tonumber(stdout) or 0
        audio_widget.container.audio_layout.spacing = dpi(5)
        audio_widget.container.audio_layout.label.visible = true

        if volume >= 0 and volume < 34 then
          icon = icon .. "-low"
        elseif volume >= 34 and volume < 67 then
          icon = icon .. "-medium"
        elseif volume >= 67 then
          icon = icon .. "-high"
        end
        audio_widget.container.audio_layout.label:set_text("ılı " .. volume .. "%")
        awesome.emit_signal("get::volume", volume)
      end
    )
  end

  local check_muted = function()
    awful.spawn.easy_async_with_shell(
      "./.config/awesome/src/scripts/vol.sh mute",
      function(stdout)
        if stdout:match("yes") then
          audio_widget.container.audio_layout.label.visible = false
          audio_widget.container:set_right(0)
          awesome.emit_signal("get::volume_mute", true)
        else
          audio_widget.container:set_right(10)
          awesome.emit_signal("get::volume_mute", false)
          get_volume()
        end
      end
    )
  end

  -- Signals
  Hover_signal(audio_widget, color["Yellow200"], color["Grey900"])

  audio_widget:connect_signal(
    "button::press",
    function()
      awesome.emit_signal("module::slider:update")
      awesome.emit_signal("widget::volume_osd:rerun")
      awesome.emit_signal("volume_controller::toggle", s)
      awesome.emit_signal("volume_controller::toggle:keygrabber")
    end
  )

  gears.timer {
    timeout = 0.5,
    call_now = true,
    autostart = true,
    callback = check_muted
  }

  check_muted()
  return audio_widget
end

