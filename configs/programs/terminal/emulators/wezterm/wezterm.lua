local wezterm = require("wezterm")
local config = {}
config.font = wezterm.font({ family = "Hack Nerd Font", weight = "Regular" })
config.font_size = 9
config.colors = {
	foreground = "#FF0055",
	background = "#110015",
	cursor_bg = "#ffffff",
	cursor_fg = "#000000",
	cursor_border = "#ffffff",
	selection_fg = "none",
	selection_bg = "#563466",

	-- The color of the split lines between panes
	split = "#444444",

	ansi = {
		"#000000",
		"#FF0055",
		"#009550",
		"#F4EF00",
		"#6766B3",
		"#D57BFF",
		"#0DCDCD",
		"#EEFFFF",
	},
	brights = {
		"#777777",
		"#FF4081",
		"#00FF9C",
		"#FFFC58",
		"#76C1FF",
		"#C592FF",
		"#00FFC8",
		"#FFFFFF",
	},
}

config.window_background_opacity = 0.9

return config
