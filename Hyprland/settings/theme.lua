hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,
		border_size = 0,
		layout = "dwindle",
		-- layout        = "master",
		-- layout        = "scrolling",
		resize_on_border = true,
	},

	group = {
		col = {
			border_active = { colors = { "rgba(ca9ee6ff)", "rgba(f2d5cfff)" }, angle = 45 },
			border_inactive = { colors = { "rgba(b4befecc)", "rgba(6c7086cc)" }, angle = 45 },
			border_locked_active = { colors = { "rgba(ca9ee6ff)", "rgba(f2d5cfff)" }, angle = 45 },
			border_locked_inactive = { colors = { "rgba(b4befecc)", "rgba(6c7086cc)" }, angle = 45 },
		},
	},

	decoration = {
		rounding = 12,
		shadow = {
			enabled = false,
		},

		blur = {
			enabled = false,
			size = 2,
			passes = 2,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
		},
	},
})
