-- Awesome Libs
local awful = require("awful")
local gears = require("gears")

local modkey = user_vars.modkey

----Function to focus the client under the mouse cursor
--local function focus_client_under_mouse()
--    -- Get the mouse coordinates
--    local x, y = mouse.coords()
--
--    -- Find the client (window) under the mouse cursor
--    local c = awful.mouse.client_under_pointer()
--
--  -- Check if a client was found
--    if c then
--        -- Focus the client
--        client.focus = c
--        --c:raise()
--    end
--end
--
---- Periodically check and focus the client under the mouse cursor
--local mouse_focus_timer = gears.timer {
--    timeout = 0.1, -- Adjust the timeout as needed (1000 ms in this example)
--    autostart = true,
--    callback = function()
--        focus_client_under_mouse()
--    end
--}

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
	end)
)
