-- Application bindings.
o.bind("SUPER + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + ALT + RETURN", "Tmux", { omarchy = "terminal-tmux" })
o.bind("SUPER + SHIFT + RETURN", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + SHIFT + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + SHIFT + M", "Music", { omarchy = "or-focus spotify" })
o.bind("SUPER + SHIFT + ALT + M", "Music TUI", { tui = "cliamp", focus = true })
-- o.bind("SUPER + SHIFT + N", "Editor", { omarchy = "editor" })
o.bind("SUPER + SHIFT + D", "Docker", { tui = "lazydocker" })
o.bind("SUPER + SHIFT + G", "Signal", { launch = "signal-desktop", focus = "^signal$" })
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "1password" })

-- Web app bindings.
o.bind("SUPER + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + SHIFT + ALT + A", "Grok", { webapp = "https://grok.com" })
o.bind("SUPER + SHIFT + C", "Calendar", { webapp = "https://app.hey.com/calendar/weeks/" })
o.bind("SUPER + SHIFT + E", "Email", { webapp = "https://app.hey.com" })
o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })
o.bind("SUPER + SHIFT + ALT + G", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind(
	"SUPER + SHIFT + CTRL + G",
	"Google Messages",
	{ webapp = "https://messages.google.com/web/conversations", focus = true }
)
o.bind("SUPER + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/", focus = true })
o.bind("SUPER + SHIFT + S", "Google Maps", { webapp = "https://maps.google.com/", focus = true })
o.bind("SUPER + SHIFT + X", "X", { webapp = "https://x.com/" })
o.bind("SUPER + SHIFT + ALT + X", "X Post", { webapp = "https://x.com/compose/post" })

-- Add extra bindings below.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Overwrite existing bindings with hl.unbind() first if needed.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, { omarchy = "walker -m symbols" })

-- Converted bindings from legacy `bindings.conf`
-- Unbind conflicting/default keys first
hl.unbind("SUPER + F")
hl.unbind("SUPER + S")
hl.unbind("SUPER + RETURN")
hl.unbind("SUPER + M")
hl.unbind("SUPER + N")
hl.unbind("SUPER + A")

-- Application bindings
o.bind(
	"SUPER + ALT + RETURN",
	"Tmux",
	{ launch = 'uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" tmux new' }
)
o.bind("SUPER + RETURN", "Terminal", { launch = "ghostty" })

hl.unbind("SUPER + SHIFT + PSPACE")
o.bind("SUPER + SHIFT + P", "Screenshot", { launch = "omarchy capture screenshot window copy" })
-- o.bind("SUPER + RETURN", "Terminal", { launch = "$TERMINAL" }) -- alternative

o.bind("SUPER + F", "File manager", { launch = "uwsm app -- nautilus --new-window" })
o.bind("SUPER + S", "Browser", { launch = "omarchy-launch-browser" })
o.bind("SUPER + SHIFT + S", "Browser (private)", { launch = "omarchy-launch-browser --private" })

o.bind("SUPER + E", "Emacs", { launch = "emacs" })
o.bind("SUPER + Y", "YouTube", { launch = 'omarchy-launch-or-focus-webapp YouTube "https://youtube.com/"' })
o.bind(
	"SUPER + SHIFT + G",
	"WhatsApp",
	{ launch = 'omarchy-launch-or-focus-webapp WhatsApp "https://web.whatsapp.com/"', focus = true }
)
o.bind("SUPER + ALT + G", "Google Messages", {
	launch = 'omarchy-launch-or-focus-webapp "Google Messages" "https://messages.google.com/web/conversations"',
	focus = true,
})

-- Window management
-- Fullscreen (maximize mode)
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Minimize: move active window to a special workspace
hl.bind("SUPER + N", function()
	local win = hl.get_active_window()
	if win.workspace.name:find("^special:minimized") then
		-- Window is in a special/minimized workspace — unminimize it
		local target_id = win.workspace.name:match("minimized_(%d+)")
		hl.dispatch(hl.dsp.window.move({ workspace = target_id }))
	else
		-- Minimize
		hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized_" .. win.workspace.id, follow = false }))
	end
end)

-- Show all minimized windows for current workspace (toggle special workspace overlay)
hl.bind("SUPER + A", function()
	local ws = hl.get_active_workspace()
	hl.dispatch(hl.dsp.workspace.toggle_special("minimized_" .. ws.id))
end)

-- Unminimize: move window from special back to current workspace
hl.bind("SUPER + SHIFT + N", function()
	local ws = hl.get_active_workspace()
	hl.dispatch(hl.dsp.window.move({ workspace = tostring(ws.id) }))
end)

-- Misc bindings
hl.unbind("SUPER + SHIFT + SPACE")
o.bind("SUPER + SHIFT + SPACE", "List current windows", { launch = "walker -m windows" })
o.bind("SUPER + ALT + CTRL + 4", "Screenshot with editing", { launch = "omarchy-capture-screenshot" })
-- o.bind("SUPER + CTRL + 4", "Screenshot to clipboard", { launch = "omarchy-cmd-screenshot smart clipboard" })

local hs = require("hyprsplit")
-- hyprsplit bindings
for i = 1, 10 do
	local key = "code:" .. tostring(i + 9)
	hl.unbind("SUPER + " .. key)
	hl.unbind("SUPER + SHIFT + " .. key)
	hl.bind("SUPER + " .. key, hs.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hs.dsp.window.move({ workspace = i, follow = false }))
end

hl.unbind("SUPER + TAB")
hl.unbind("SUPER + SHIFT + TAB")
hl.bind("SUPER + TAB", hs.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + SHIFT + TAB", hs.dsp.focus({ workspace = "r-1" }))
