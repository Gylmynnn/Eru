local constants = require("constants")
local scrPath = constants.scrPath
local GTK_THEME = constants.GTK_THEME
local ICON_THEME = constants.ICON_THEME
local COLOR_SCHEME = constants.COLOR_SCHEME

hl.on("hyprland.start", function()
	hl.exec_cmd('gsettings set org.gnome.desktop.interface icon-theme "' .. ICON_THEME .. '"')
	hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "' .. GTK_THEME .. '"')
	hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "' .. COLOR_SCHEME .. '"')
	hl.exec_cmd(scrPath .. "/resetxdgportal.sh")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd(scrPath .. "/polkitkdeauth.sh")
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("udiskie --no-automount --smart-tray")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd(scrPath .. "/swwwallpaper.sh")
	hl.exec_cmd(scrPath .. "/batterynotify.sh")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("hyprpm reload")
end)
