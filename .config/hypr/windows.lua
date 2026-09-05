-- set full opacity in vscode and ghostty
hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ match = { class = "code" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({
	opacity = "1.0 override 1.0 override",
	match = {
		class = ".*",
	},
})

