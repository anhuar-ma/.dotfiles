-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and resolutions possible: hyprctl monitors all

local omarchy_gdk_scale = 1.0
local omarchy_monitor_scale = 1.0

-- Optimized for retina-class 2x displays, like 13" 2.8K, 27" 5K, 32" 6K.
-- local omarchy_gdk_scale = 2
-- local omarchy_monitor_scale = "auto"

-- Good compromise for 27" or 32" 4K monitors (but fractional!): monitor scale 1.6, GDK scale 1.75.
-- local omarchy_gdk_scale = 1.75
-- local omarchy_monitor_scale = 1.6

-- Straight 1x setup for low-resolution displays like 1080p, 1440p, or ultrawides: both 1.
-- local omarchy_gdk_scale = 1
-- local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°)
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Example for Framework 13 w/ 6K XDR Apple display.
-- hl.monitor({ output = "DP-5", mode = "6016x3384@60", position = "auto", scale = 2 })
-- hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "auto", scale = 2 })

-- Disable the second ghost monitor on an Apple 6K XDR over Thunderbolt.
-- hl.monitor({ output = "DP-2", disabled = true })

-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Converted monitors from old `monitors.conf` syntax:
-- monitor=DP-1,3840x2160@60.0,3185x1080,1.2
hl.monitor({ output = "eDP-1", mode = "1920x1089@60.0", position = "0x0", scale = 1.0 })

-- monitor=HDMI-A-1,1920x1080@60.0,6385x1355,1.0
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60.0", position = "6385x1355", scale = 1.0 })

-- -- monitor=DP-3,2560x1440@144.0,1745x939,1.0
-- -- monitor=DP-3,transform,1  -> combined transform into the same entry
-- hl.monitor({ output = "DP-3", mode = "2560x1440@144.0", position = "1745x939", scale = 1.0, transform = 1 })
