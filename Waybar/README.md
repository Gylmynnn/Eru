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

Or use the automated script (Arch-based distros only):

```bash
bash Waybar/install.sh
```

This script will:

- check whether `waybar` is already installed,
- install `waybar` if it is missing,
- back up existing config to `~/.config/waybar.backup-<timestamp>` (if present),
- deploy the latest `config.jsonc` and `style.css`,
- restart Waybar if it is currently running.

## Uninstall

Use the following script to uninstall:

```bash
bash Waybar/uninstall.sh
```

The uninstall script will:

- check `waybar` installation status,
- stop Waybar process (if running),
- remove config files deployed by the script (`config.jsonc` and `style.css`),
- remove the `waybar` package via `pacman -Rns` if installed.

Restart Waybar:

```bash
pkill waybar
waybar &
```

## Quick Customization

- Change launcher commands in `config.jsonc` under `on-click`.
- Adjust colors and spacing in `style.css`.
- If your script paths are different, update custom script paths in `config.jsonc`.
