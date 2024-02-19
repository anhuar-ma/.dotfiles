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
    function()
      local c = awful.mouse.client_under_pointer()
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "Client" }
  ),
  awful.key(
    { modkey, "Shift" },
    "Tab",
    function()
       -- local clients = client.get()  -- Get all clients
     local tag = awful.screen.focused().selected_tag

      for _, c in pairs(tag:clients()) do
            c.maximized = false  -- Unmaximize the client
            c.minimized = false  -- Unmaximize the client
    end
    end,
    { description = "Close focused client", group = "Client" }
  ),

  awful.key(
    { modkey },
    "n",
    function()

 local current_client = client.focus  -- Store the currently focused client
    local client_under_pointer = awful.mouse.client_under_pointer()

    if client_under_pointer then
        -- Focus the client under the pointer, minimize it, then restore focus
        client.focus = client_under_pointer
        client_under_pointer.minimized = true
        client.focus = current_client
    end

    end,
    { description = "(un)hide", group = "Client" }
  )
)
