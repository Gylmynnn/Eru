# Kitty Dotfiles

Modern GPU-based terminal emulator configuration with custom theming and tab styling.
![Kitty preview](kitty.png)

## Folder Contents

- `kitty.conf` - Main terminal configuration (fonts, padding, window settings, bell, cursor).
- `theme.conf` - Color scheme and theme settings.
- `tabstyle.conf` - Tab bar customization.
- `everblush-theme.conf` - Everblush color theme.
- `tab_bar.py` - Custom Python script for tab bar rendering.
- `kitty.conf.bak` - Backup of original configuration.

## Features

- **High-performance rendering**: GPU-based terminal for fast text rendering.
- **Custom fonts**: Iosevka Nerd Font with optimized cell width and height.
- **Modern tab styling**: Customizable tab appearance with Python-based rendering.
- **Catppuccin-inspired theme**: Beautiful color scheme with Everblush variant.
- **Cursor customization**: Enabled cursor trail for smooth visual feedback.
- **Window positioning**: Configurable margins and padding for window management.
- **Audio bell control**: Disable audio bell to reduce distractions.
- **Scrollback management**: Disabled scrollback for terminal cleanliness.

## Dependencies

Minimum:

- `kitty` (GPU-based terminal emulator)
- `Iosevka Nerd Font` (or any Nerd Font of your choice)

Optional (for full customization):

- Python 3.x (for `tab_bar.py` customization)
- Additional Nerd Fonts (for fallback glyphs)

## Installation

Manual installation:

```bash
mkdir -p ~/.config/kitty
cp Kitty/kitty.conf ~/.config/kitty/kitty.conf
cp Kitty/theme.conf ~/.config/kitty/theme.conf
cp Kitty/tabstyle.conf ~/.config/kitty/tabstyle.conf
cp Kitty/everblush-theme.conf ~/.config/kitty/everblush-theme.conf
cp Kitty/tab_bar.py ~/.config/kitty/tab_bar.py
```

## Configuration

### Font Customization

Edit the font settings in `kitty.conf`:

```
font_family      family="Iosevka Nerd Font"
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 19.0
```

### Window and Padding

Adjust margins and padding:

```
window_padding_width 0
window_margin_width 10 10 10 10
```

### Theme Colors

Switch themes by modifying the `include` statements at the top of `kitty.conf`. Currently includes:

- `theme.conf` - Main theme
- `everblush-theme.conf` - Everblush color scheme
- `tabstyle.conf` - Tab styling

### Cursor Customization

Enable/disable cursor trail:

```
cursor_trail 3
cursor_trail_decay 0.1 0.4
```

## Restart Kitty

After making configuration changes, restart Kitty:

```bash
pkill kitty
kitty &
```

Or reload the configuration without restarting:

```bash
kitten reload-config
```

## Quick Customization

- **Change font**: Modify `font_family` and `font_size` in `kitty.conf`.
- **Adjust colors**: Edit `theme.conf` or `everblush-theme.conf` to customize the color palette.
- **Modify tab appearance**: Edit `tabstyle.conf` or customize `tab_bar.py`.
- **Window sizing**: Adjust `window_padding_width` and `window_margin_width` in `kitty.conf`.
- **Disable audio bell**: Keep `enable_audio_bell no` to maintain a quiet terminal experience.

## Useful Kitty Keyboard Shortcuts

```bash
# New window
Ctrl+Shift+N

# New tab
Ctrl+Shift+T

# Close tab
Ctrl+Shift+W

# Next tab
Ctrl+Shift+Right

# Previous tab
Ctrl+Shift+Left

# Increase font size
Ctrl+Shift+Equal

# Decrease font size
Ctrl+Shift+Minus

# Reset font size
Ctrl+Shift+BackSpace

# Copy to clipboard
Ctrl+Shift+C

# Paste from clipboard
Ctrl+Shift+V

# Open URL under cursor
Ctrl+Shift+E
```

## Additional Resources

- [Kitty Documentation](https://sw.kovidgoyal.net/kitty/)
- [Nerd Fonts](https://www.nerdfonts.com/)
