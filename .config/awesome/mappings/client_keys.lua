-- Awesome Libs
local awful = require("awful")
local gears = require("gears")

local modkey = user_vars.modkey

-- Function to kill the current window under the mouse pointer
function kill_current_window()
    -- Get the client (window) under the mouse pointer
    local c = awful.mouse.client_under_pointer()

    -- Check if a client was found
    if c then
        -- Kill (close) the client
        c:kill()
    end
end






return gears.table.join(
  awful.key(
    { modkey },
    "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "Toggle fullscreen", group = "Client" }
  ),
  awful.key(
    { modkey },
    "q",
    function()
        kill_current_window()
    end,
    { description = "Close focused client", group = "Client" }
  ),

  awful.key(
  {modkey, "Control"},
  "q",
  -- Function to close all windows on the current desktop (tag)
function ()
    -- Get the current tag (desktop)
    local current_tag = awful.screen.focused().selected_tag

    -- Iterate through all clients and close the ones on the current tag
    for _, c in ipairs(current_tag:clients()) do
        c:kill()
    end
end),



  awful.key(
    { modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "Toggle floating window", group = "Client" }
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

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "client"}),

 awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),

--minimize all the windows

    awful.key({ modkey}, "m",
              function ()

                     -- Get the current tag (desktop)
    local current_tag = awful.screen.focused().selected_tag

    -- Iterate through all clients and close the ones on the current tag
    for _, c in ipairs(current_tag:clients()) do
        c.minimized = true
    end
end),
--unminimize all the windows

    awful.key({ modkey, "Control" }, "m",
              function ()

                     -- Get the current tag (desktop)
    local current_tag = awful.screen.focused().selected_tag

    -- Iterate through all clients and close the ones on the current tag
    for _, c in ipairs(current_tag:clients()) do
        c.minimized = false
    end
end)

)
