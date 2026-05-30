# Nwgbar Dotfiles

Simple and elegant power menu bar for Hyprland using nwg-bar.

## Folder Contents

- `bar.json` - Power menu configuration (lock, sleep, exit, reboot, poweroff).
- `style.css` - Bar styling (colors, borders, hover effects, and themes).
- `assets/` - SVG icons for power options (lock, sleep, exit, reboot, poweroff).

## Features

- **Quick power actions**: Lock screen, suspend, exit Hyprland, reboot, and poweroff.
- **Customizable icons**: SVG-based icons stored in `assets/` folder.
- **Themed styling**: Catppuccin-inspired colors with hover effects.
- **Responsive buttons**: Styled button interactions with color transitions.
- **Shutdown warnings**: Red-themed styling for destructive actions.

## Dependencies

Minimum:

- `nwg-bar`
- `hyprland` (for `hyprctl` commands)
- `hyprlock` (for lock functionality)

Optional (for customization):

- An SVG editor (e.g., Inkscape) to customize icons.

## Installation

Manual installation:

```bash
mkdir -p ~/.config/nwg-bar
cp Nwgbar/bar.json ~/.config/nwg-bar/bar.json
cp Nwgbar/style.css ~/.config/nwg-bar/style.css
cp -r Nwgbar/assets ~/.config/nwg-bar/
```

Or use the automated script (Arch-based distros only):

```bash
bash Nwgbar/install.sh
```

This script will:

- check whether `nwg-bar` is already installed,
- install `nwg-bar` if it is missing,
- back up existing config to `~/.config/nwg-bar.backup-<timestamp>` (if present),
- deploy the latest `bar.json`, `style.css`, and `assets/`.

## Usage

Launch the power menu from Hyprland:

```bash
nwg-bar
```

Or bind it to a keyboard shortcut in your Hyprland config:

```
bind = $mainMod, Escape, exec, nwg-bar
```

## Uninstall

Use the following script to uninstall:

```bash
bash Nwgbar/uninstall.sh
```

The uninstall script will:

- check `nwg-bar` installation status,
- remove config files deployed by the script (`bar.json`, `style.css`, and `assets/`),
- remove the `nwg-bar` package via `pacman -Rns` if installed.

## Quick Customization

- **Change colors**: Edit `style.css` to adjust button colors and hover effects.
- **Add/remove buttons**: Edit `bar.json` to add, remove, or modify power options.
- **Replace icons**: Replace SVG files in `assets/` with your own custom icons.
- **Adjust button layout**: Modify padding and border-radius in `style.css`.

## Related Commands

```bash
# Lock screen
hyprlock

# Suspend system
systemctl suspend

# Exit Hyprland
hyprctl dispatch exit

# Reboot system
systemctl reboot

# Power off system
systemctl poweroff
```
