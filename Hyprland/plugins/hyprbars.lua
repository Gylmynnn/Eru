hl.config({
	plugin = {
		hyprbars = {
			bar_height = 42,
			bar_color = "rgba(141b1eff)",
			bar_padding = 20,
			bar_blur = false,
			bar_title_format = "%i",
			bar_title_enabled = false,
			bar_text_font = "JetBrainsMono Nerd Font",
			bar_text_size = 12,
			bar_buttons_alignment = "left",
		},
	},
})

hl.plugin.hyprbars.add_button({
	bg_color = "rgb(ff5f57)",
	size = 18,
	icon = "",
	action = "hyprctl dispatch killactive",
})
hl.plugin.hyprbars.add_button({
	bg_color = "rgb(febc2e)",
	size = 18,
	icon = "",
	action = "hyprctl dispatch fullscreen 1",
})
hl.plugin.hyprbars.add_button({
	bg_color = "rgb(28c840)",
	size = 18,
	icon = "",
	action = "hyprctl dispatch togglefloating",
})
