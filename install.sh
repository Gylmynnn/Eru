#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  echo "Usage: $0 {all|component...}"
  echo "Example : ./install.sh waybar"
  echo ""
  echo "Components:"
  echo "  waybar    Install Waybar configuration"
  echo "  dunst     Install Dunst configuration"
  echo "  fish      Install Fish shell configuration"
  echo "  kitty     Install Kitty terminal configuration"
  echo "  neovim    Install Neovim configuration"
  echo "  nwgbar    Install Nwg-bar configuration"
  echo "  starship  Install Starship prompt configuration"
  echo "  all       Install all components"
  exit 1
}

install_waybar() {
  echo "=== Installing Waybar ==="
  local src_config="$SCRIPT_DIR/Waybar/config.jsonc"
  local src_style="$SCRIPT_DIR/Waybar/style.css"
  local target_dir="$HOME/.config/waybar"
  local target_config="$target_dir/config.jsonc"
  local target_style="$target_dir/style.css"

  if [[ ! -f "$src_config" || ! -f "$src_style" ]]; then
    echo "Source config files were not found in the Waybar folder."
    exit 1
  fi

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if ! pacman -Q waybar >/dev/null 2>&1; then
    echo "Waybar is not installed. Installing waybar..."
    sudo pacman -S --needed waybar
  else
    echo "Waybar is already installed."
  fi

  mkdir -p "$target_dir"

  if [[ -f "$target_config" || -f "$target_style" ]]; then
    local backup_dir="$HOME/.config/waybar.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    [[ -f "$target_config" ]] && cp "$target_config" "$backup_dir/config.jsonc"
    [[ -f "$target_style" ]] && cp "$target_style" "$backup_dir/style.css"
    echo "Existing config backed up to: $backup_dir"
  fi

  cp "$src_config" "$target_config"
  cp "$src_style" "$target_style"

  echo "Waybar config installed at: $target_dir"

  if pgrep -x waybar >/dev/null 2>&1; then
    pkill waybar
    nohup waybar >/dev/null 2>&1 &
    echo "Waybar restarted."
  else
    echo "Waybar is not running. Start it manually with: waybar"
  fi
  echo "Done."
}

install_dunst() {
  echo "=== Installing Dunst ==="
  local src_config="$SCRIPT_DIR/Dunst/dunstrc"
  local target_dir="$HOME/.config/dunst"
  local target_config="$target_dir/dunstrc"

  if [[ ! -f "$src_config" ]]; then
    echo "Source dunstrc was not found in the Dunst folder."
    exit 1
  fi

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if ! pacman -Q dunst >/dev/null 2>&1; then
    echo "Dunst is not installed. Installing dunst..."
    sudo pacman -S --needed dunst libnotify
  else
    echo "Dunst is already installed."
  fi

  mkdir -p "$target_dir"

  if [[ -f "$target_config" ]]; then
    local backup_dir="$HOME/.config/dunst.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    cp "$target_config" "$backup_dir/dunstrc"
    echo "Existing config backed up to: $backup_dir"
  fi

  cp "$src_config" "$target_config"
  echo "Dunst config installed at: $target_dir"

  if pgrep -x dunst >/dev/null 2>&1; then
    pkill dunst
    nohup dunst >/dev/null 2>&1 &
    echo "Dunst restarted."
  else
    echo "Dunst is not running. Start it manually with: dunst"
  fi
  echo "Done."
}

install_fish() {
  echo "=== Installing Fish ==="
  local src_configs=(
    "$SCRIPT_DIR/Fish/config.fish"
    "$SCRIPT_DIR/Fish/env.fish"
    "$SCRIPT_DIR/Fish/fish_plugins"
    "$SCRIPT_DIR/Fish/conf.d"
    "$SCRIPT_DIR/Fish/functions"
    "$SCRIPT_DIR/Fish/completions"
  )
  local target_dir="$HOME/.config/fish"

  local missing=false
  for src in "${src_configs[@]}"; do
    if [[ ! -e "$src" ]]; then
      echo "Missing: $src"
      missing=true
    fi
  done
  if [[ "$missing" == true ]]; then
    echo "Source config files were not found in the Fish folder."
    exit 1
  fi

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if ! pacman -Q fish >/dev/null 2>&1; then
    echo "Fish is not installed. Installing fish..."
    sudo pacman -S --needed fish
  else
    echo "Fish is already installed."
  fi

  mkdir -p "$target_dir"

  if [[ -d "$target_dir" ]] && ls -A "$target_dir" | grep -qv '^fish_variables$'; then
    local backup_dir="$HOME/.config/fish.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    for item in "$target_dir"/*; do
      local name="$(basename "$item")"
      [[ "$name" == "fish_variables" ]] && continue
      cp -r "$item" "$backup_dir/"
    done
    echo "Existing config backed up to: $backup_dir"
  fi

  cp "$SCRIPT_DIR/Fish/config.fish" "$target_dir/config.fish"
  cp "$SCRIPT_DIR/Fish/env.fish" "$target_dir/env.fish"
  cp "$SCRIPT_DIR/Fish/fish_plugins" "$target_dir/fish_plugins"
  cp -r "$SCRIPT_DIR/Fish/conf.d" "$target_dir/"
  cp -r "$SCRIPT_DIR/Fish/functions" "$target_dir/"
  cp -r "$SCRIPT_DIR/Fish/completions" "$target_dir/"

  echo "Fish config installed at: $target_dir"

  if command -v fish >/dev/null 2>&1; then
    echo ""
    echo "To install fisher and plugins, run:"
    echo "  fish -c 'fisher update'"
  fi
  echo "Done."
}

install_kitty() {
  echo "=== Installing Kitty ==="
  local src_configs=(
    "$SCRIPT_DIR/Kitty/kitty.conf"
    "$SCRIPT_DIR/Kitty/theme.conf"
    "$SCRIPT_DIR/Kitty/tabstyle.conf"
    "$SCRIPT_DIR/Kitty/everblush-theme.conf"
    "$SCRIPT_DIR/Kitty/tab_bar.py"
  )
  local target_dir="$HOME/.config/kitty"

  local missing=false
  for src in "${src_configs[@]}"; do
    if [[ ! -e "$src" ]]; then
      echo "Missing: $src"
      missing=true
    fi
  done
  if [[ "$missing" == true ]]; then
    echo "Source config files were not found in the Kitty folder."
    exit 1
  fi

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if ! pacman -Q kitty >/dev/null 2>&1; then
    echo "Kitty is not installed. Installing kitty..."
    sudo pacman -S --needed kitty
  else
    echo "Kitty is already installed."
  fi

  mkdir -p "$target_dir"

  if [[ -f "$target_dir/kitty.conf" || -f "$target_dir/theme.conf" || -f "$target_dir/tabstyle.conf" ]]; then
    local backup_dir="$HOME/.config/kitty.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    [[ -f "$target_dir/kitty.conf" ]] && cp "$target_dir/kitty.conf" "$backup_dir/kitty.conf"
    [[ -f "$target_dir/theme.conf" ]] && cp "$target_dir/theme.conf" "$backup_dir/theme.conf"
    [[ -f "$target_dir/tabstyle.conf" ]] && cp "$target_dir/tabstyle.conf" "$backup_dir/tabstyle.conf"
    [[ -f "$target_dir/everblush-theme.conf" ]] && cp "$target_dir/everblush-theme.conf" "$backup_dir/everblush-theme.conf"
    [[ -f "$target_dir/tab_bar.py" ]] && cp "$target_dir/tab_bar.py" "$backup_dir/tab_bar.py"
    echo "Existing config backed up to: $backup_dir"
  fi

  cp "$SCRIPT_DIR/Kitty/kitty.conf" "$target_dir/kitty.conf"
  cp "$SCRIPT_DIR/Kitty/theme.conf" "$target_dir/theme.conf"
  cp "$SCRIPT_DIR/Kitty/tabstyle.conf" "$target_dir/tabstyle.conf"
  cp "$SCRIPT_DIR/Kitty/everblush-theme.conf" "$target_dir/everblush-theme.conf"
  cp "$SCRIPT_DIR/Kitty/tab_bar.py" "$target_dir/tab_bar.py"

  echo "Kitty config installed at: $target_dir"

  if pgrep -x kitty >/dev/null 2>&1; then
    echo ""
    echo "Kitty is currently running. Restart Kitty for changes to take effect:"
    echo "  pkill kitty"
    echo "  kitty &"
  else
    echo ""
    echo "To launch Kitty, run:"
    echo "  kitty"
  fi
  echo "Done."
}

install_neovim() {
  echo "=== Installing Neovim ==="
  local src_init="$SCRIPT_DIR/Neovim/init.lua"
  local src_lua="$SCRIPT_DIR/Neovim/lua"
  local src_luarc="$SCRIPT_DIR/Neovim/.luarc.json"
  local src_stylua="$SCRIPT_DIR/Neovim/.stylua.toml"
  local src_lazy_lock="$SCRIPT_DIR/Neovim/lazy-lock.json"
  local target_dir="$HOME/.config/nvim"

  if [[ ! -f "$src_init" || ! -d "$src_lua" ]]; then
    echo "Source config files were not found in the Neovim folder."
    exit 1
  fi

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if ! pacman -Q neovim >/dev/null 2>&1; then
    echo "Neovim is not installed. Installing neovim..."
    sudo pacman -S --needed neovim
  else
    echo "Neovim is already installed."
  fi

  mkdir -p "$target_dir"

  if [[ -f "$target_dir/init.lua" || -d "$target_dir/lua" ]]; then
    local backup_dir="$HOME/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    [[ -f "$target_dir/init.lua" ]] && cp "$target_dir/init.lua" "$backup_dir/init.lua"
    [[ -d "$target_dir/lua" ]] && cp -r "$target_dir/lua" "$backup_dir/"
    [[ -f "$target_dir/.luarc.json" ]] && cp "$target_dir/.luarc.json" "$backup_dir/.luarc.json"
    [[ -f "$target_dir/.stylua.toml" ]] && cp "$target_dir/.stylua.toml" "$backup_dir/.stylua.toml"
    [[ -f "$target_dir/lazy-lock.json" ]] && cp "$target_dir/lazy-lock.json" "$backup_dir/lazy-lock.json"
    echo "Existing config backed up to: $backup_dir"
  fi

  cp "$src_init" "$target_dir/init.lua"
  cp -r "$src_lua" "$target_dir/"
  [[ -f "$src_luarc" ]] && cp "$src_luarc" "$target_dir/.luarc.json"
  [[ -f "$src_stylua" ]] && cp "$src_stylua" "$target_dir/.stylua.toml"
  [[ -f "$src_lazy_lock" ]] && cp "$src_lazy_lock" "$target_dir/lazy-lock.json"

  echo "Neovim config installed at: $target_dir"
  echo ""
  echo "Run 'nvim' to start Neovim. On first run, it will automatically:"
  echo "  - Install lazy.nvim plugin manager"
  echo "  - Download and setup all plugins"
  echo "  - Install LSP servers and tools"
  echo ""
  echo "Done."
}

install_nwgbar() {
  echo "=== Installing Nwg-bar ==="
  local src_config="$SCRIPT_DIR/Nwgbar/bar.json"
  local src_style="$SCRIPT_DIR/Nwgbar/style.css"
  local src_assets="$SCRIPT_DIR/Nwgbar/assets"
  local target_dir="$HOME/.config/nwg-bar"
  local target_config="$target_dir/bar.json"
  local target_style="$target_dir/style.css"
  local target_assets="$target_dir/assets"

  local missing=false
  for src in "$src_config" "$src_style" "$src_assets"; do
    if [[ ! -e "$src" ]]; then
      echo "Missing: $src"
      missing=true
    fi
  done
  if [[ "$missing" == true ]]; then
    echo "Source config files were not found in the Nwgbar folder."
    exit 1
  fi

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if ! pacman -Q nwg-bar >/dev/null 2>&1; then
    echo "Nwg-bar is not installed. Installing nwg-bar..."
    sudo pacman -S --needed nwg-bar
  else
    echo "Nwg-bar is already installed."
  fi

  mkdir -p "$target_dir"

  if [[ -f "$target_config" || -f "$target_style" || -d "$target_assets" ]]; then
    local backup_dir="$HOME/.config/nwg-bar.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    [[ -f "$target_config" ]] && cp "$target_config" "$backup_dir/bar.json"
    [[ -f "$target_style" ]] && cp "$target_style" "$backup_dir/style.css"
    [[ -d "$target_assets" ]] && cp -r "$target_assets" "$backup_dir/"
    echo "Existing config backed up to: $backup_dir"
  fi

  cp "$src_config" "$target_config"
  cp "$src_style" "$target_style"
  cp -r "$src_assets" "$target_dir/"

  echo "Nwg-bar config installed at: $target_dir"
  echo ""
  echo "To launch the power menu, run:"
  echo "  nwg-bar"
  echo ""
  echo "Or bind it to a keyboard shortcut in your Hyprland config:"
  echo "  bind = \$mainMod, Escape, exec, nwg-bar"
  echo "Done."
}

install_starship() {
  echo "=== Installing Starship ==="
  local src_config="$SCRIPT_DIR/Starship/starship.toml"
  local target_dir="$HOME/.config/starship"
  local target_config="$target_dir/starship.toml"

  if [[ ! -f "$src_config" ]]; then
    echo "Source starship.toml was not found in the Starship folder."
    exit 1
  fi

  if ! command -v starship >/dev/null 2>&1; then
    echo "Starship is not installed. Installing starship..."
    if command -v pacman >/dev/null 2>&1; then
      sudo pacman -S --needed starship
    elif command -v curl >/dev/null 2>&1; then
      sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
    else
      echo "Please install starship manually: https://starship.rs"
      exit 1
    fi
  else
    echo "Starship is already installed."
  fi

  mkdir -p "$target_dir"

  if [[ -f "$target_config" ]]; then
    local backup_dir="$HOME/.config/starship.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    cp "$target_config" "$backup_dir/starship.toml"
    echo "Existing config backed up to: $backup_dir"
  fi

  cp "$src_config" "$target_config"
  echo "Starship config installed at: $target_config"
  echo ""
  echo "Add the following to your shell config (~/.bashrc, ~/.zshrc, etc.):"
  echo '  eval "$(starship init bash)"'
  echo "Done."
}

if [[ $# -eq 0 ]]; then
  usage
fi

for arg in "$@"; do
  case "${arg,,}" in
    all)
      install_waybar
      install_dunst
      install_fish
      install_kitty
      install_neovim
      install_nwgbar
      install_starship
      ;;
    waybar) install_waybar ;;
    dunst) install_dunst ;;
    fish) install_fish ;;
    kitty) install_kitty ;;
    neovim) install_neovim ;;
    nwgbar) install_nwgbar ;;
    starship) install_starship ;;
    *)
      echo "Unknown component: $arg"
      usage
      ;;
  esac
done
