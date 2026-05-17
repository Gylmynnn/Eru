# Fish Dotfiles

Fish shell configuration with custom functions, aliases, and integrations.

## Folder Contents

- `config.fish` - Main shell configuration (aliases, abbreviations, PATH, integrations).
- `env.fish` - Environment variables template.
- `fish_plugins` - Fisher plugin manifest.
- `fish_variables` - Universal variables.
- `functions/` - Custom shell functions.
- `conf.d/` - Fish 4.3 migration configs and theme.
- `completions/` - Custom shell completions.

## Features

- **Starship prompt** integration for a rich, customizable prompt.
- **Catppuccin theme** via Fisher plugin and syntax highlighting colors.
- **Custom functions:**
  - `pomodoro` — work/break timer with desktop notifications.
  - `fzfv` — fuzzy file finder with preview via `fd` + `fzf` + `bat`, opens in Neovim.
  - `fzfcd` — fuzzy directory navigator.
  - `extract` — universal archive extractor (tar, zip, rar, 7z, etc.).
  - `sysinfo` — quick system info overview.
  - `glog` — pretty git log graph.
  - `mkcd` — create and enter a directory.
  - `backup` — timestamped file/folder backup.
  - `cls` — thorough terminal clear.
- **Aliases:** `eza`-based `l`/`ls`/`ll`/`ld`/`lt`, `nvim` for `vim`, `git` as `g`.
- **Abbreviations:** directory navigation (`..`, `...`, ...), `:q` (exit), `:cf` (config), `:fish`/`:nvim`/`:kitty`/`:waybar`/`:hypr` (edit configs).
- **Language/Dev PATHs:** Bun, PHP (Herd), Go, Android SDK, pnpm, Cargo, Java 17.
- **Docker abbreviations:** list images, list containers, start/stop daemon.

## Dependencies

Minimum:

- `fish` (3.x+)
- `fisher` (plugin manager, installed automatically)

Optional (used by this config):

- `starship` (prompt)
- `eza` (enhanced `ls`)
- `fzf` (fuzzy finder)
- `fd` (file finder)
- `bat` (file previewer)
- `lolcat` (rainbow text for pomodoro)
- `timer` (CLI timer)
- `libnotify` (`notify-send`)
- `Neovim` (editor)

## Installation

```bash
mkdir -p ~/.config/fish
cp -r Fish/* ~/.config/fish/
```

Set your environment variables in `~/.config/fish/env.fish`:

```bash
set -Ux OPENAI_API_KEY "your-key"
```

Install Fisher and plugins:

```bash
fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher update
```

## Uninstall

```bash
rm -rf ~/.config/fish
```

Restore your shell to bash/zsh:

```bash
chsh -s /bin/bash
```

## Quick Customization

- Edit aliases and PATHs in `config.fish`.
- Add your own functions in `functions/`.
- Set environment variables in `env.fish`.
- Change the Catppuccin theme flavor in `fish_plugins` (e.g., `catppuccin/fish` for latte, frappe, macchiato, mocha).
