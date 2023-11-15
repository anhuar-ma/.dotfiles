-- Awesome Libs
local awful = require("awful")
local gears = require("gears")

local modkey = user_vars.modkey

return gears.table.join(
  awful.key(
    { modkey,   },
    "f",
    function(c)
      local c = awful.mouse.client_under_pointer()
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "Toggle fullscreen", group = "Client" }
  ),
  awful.key(
    { modkey },
    "q",
    function()
        local c = awful.mouse.client_under_pointer()

        -- Check if a client was found
        if c then
            -- Kill (close) the client
            c:kill()
        end
    end,
    { description = "Close focused client", group = "Client" }
  ),
  awful.key(
    { modkey, "Shift" },
    "q",
    function()
        local tag = awful.screen.focused().selected_tag

        for _, c in ipairs(tag:clients()) do
            c:kill()
        end 
    end,
    { description = "Close focused client", group = "Client" }
  ),
  awful.key(
    { modkey },
    "Tab",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "Client" }
  ),
  awful.key(
    { modkey },
    "n",
    function()
      local c = awful.mouse.client_under_pointer()
        c.minimized = true
    end,
    { description = "(un)hide", group = "Client" }
  )
)
