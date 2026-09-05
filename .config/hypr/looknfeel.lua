-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
	general = {
		--     -- No gaps between windows or borders.
		gaps_in = 0,
		gaps_out = 0,
		border_size = 1,
		--
		--     -- Change to niri-like side-scrolling layout.
		--     layout = "scrolling",
	},
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
	decoration = {
		-- Use round window corners.
		rounding = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		-- screen_shader = "~/.config/hypr/shaders/almost_bw.frag",
		-- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
		dim_inactive = false,
		dim_strength = 0,
	},
})

hl.config({
	master = {
		orientation = "center",
		new_status = "slave",
		allow_small_split = true,
		mfact = 0.333,
		drop_at_cursor = true,
		always_keep_position = true,
	},
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- hl.config({
--   animations = {
--     -- Disable all animations.
--     enabled = false,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })

-- Converted plugin / layout configuration from legacy syntax
-- hl.config({
--   plugin = {
--     hy3 = {
--       autotile = {
--         enable = true,
--         trigger_width = 1060,
--         trigger_height = 500,
--       },
--       tabs = {
--         height = 30,
--         padding = 5,
--         rounding = 6,
--       },
--       -- tab_first_window = true, -- enable if desired
--     },

--     nstack = {
--       layout = {
--         orientation = "left",
--         new_on_top = true,
--         new_is_master = true,
--         stacks = 3,
--       },
--     },

--     wslayout = {
--       default_layout = "dwindle",
--     },

--     hyprsplit = {
--       num_workspaces = 20,
--     },
--   },
-- })

-- Workspace bindings converted to Lua-style stubs. Uncomment and adjust if your
-- `hl` helpers provide an `hl.workspace` helper; otherwise these serve as
-- documentation of the intended mapping.
-- hl.workspace({ id = 41, monitor = "DP-3", default = true })
-- hl.workspace({ id = 21, monitor = "HDMI-A-1", default = true })

-- Change the default Omarchy look'n'feel
local hs = require("hyprsplit")

-- Hyprsplit config (replaces plugin { hyprsplit { } })
hs.config({ num_workspaces = 20 })
-- hs.monitor_priority({ "DP-1", "DP-3", "HDMI-A-1" })

-- -- Other plugins (these are still C++ hyprland plugins)
-- hl.plugin({
--     hy3 = {
--         autotile = {
--             enable = true,
--             trigger_width = 1060,
--             trigger_height = 500,
--         },
--         tabs = {
--             height = 30,
--             padding = 5,
--             rounding = 6,
--         },
--     },
--     nstack = {
--         layout = {
--             orientation = "left",
--             new_on_top = true,
--             new_is_master = true,
--             stacks = 3,
--         },
--     },
--     wslayout = {
--         default_layout = "dwindle",
--     },
-- })
