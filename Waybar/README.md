# Waybar Dotfiles

Waybar configuration for a Hyprland environment.

## Preview

![Waybar preview](waybar.png)

## Folder Contents

- `config.jsonc` - module configuration, layout, click actions, and custom module commands.
- `style.css` - Waybar styling (colors, padding, radius, font, and icon size).
- `waybar.png` - preview screenshot.

## Features

- Bottom bar position with left/center/right layout.
- Workspace indicator for Hyprland.
- Quick launcher (Kitty, Thunar, VS Code, Min browser).
- System information (CPU, memory, battery, volume, backlight, tray).
- Clock with calendar popup via `waycal`.
- Custom modules such as `cpucat` and `cava` visualizer.

## Dependencies

Minimum:

- `waybar`
- `hyprland`
- Nerd Font (example: `JetBrainsMono Nerd Font`)

Optional (used by some modules):

- `playerctl`
- `spotifatius`
- `waycal`
- `brightnessctl`
- `pavucontrol`
- `swaync` (`swaync-client`)
- `kitty`, `thunar`, `code`, `min-browser`

Referenced local scripts:

for catloop script and setup here :
[waycat](https://github.com/CarloCattano/waycat)

- `~/scripts/catloop.sh`
- `~/.config/waybar/custom-scripts/cava.sh`
- `logoutlaunch.sh`

## Installation

```bash
mkdir -p ~/.config/waybar
cp Waybar/config.jsonc ~/.config/waybar/config.jsonc
cp Waybar/style.css ~/.config/waybar/style.css
```

Restart Waybar:

```bash
pkill waybar
waybar &
```

## Quick Customization

- Change launcher commands in `config.jsonc` under `on-click`.
- Adjust colors and spacing in `style.css`.
- If your script paths are different, update custom script paths in `config.jsonc`.
