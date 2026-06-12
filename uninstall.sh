#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 {all|component...}"
  echo "Example : ./uninstall.sh waybar"
  echo ""
  echo "Components:"
  echo "  waybar    Uninstall Waybar configuration"
  echo "  dunst     Uninstall Dunst configuration"
  echo "  fish      Uninstall Fish shell configuration"
  echo "  kitty     Uninstall Kitty terminal configuration"
  echo "  neovim    Uninstall Neovim configuration"
  echo "  nwgbar    Uninstall Nwg-bar configuration"
  echo "  starship  Uninstall Starship prompt configuration"
  echo "  all       Uninstall all components"
  exit 1
}

uninstall_waybar() {
  echo "=== Uninstalling Waybar ==="
  local target_dir="$HOME/.config/waybar"
  local target_config="$target_dir/config.jsonc"
  local target_style="$target_dir/style.css"
  local is_installed=false

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if pacman -Q waybar >/dev/null 2>&1; then
    is_installed=true
    echo "Waybar is installed."
  else
    echo "Waybar is not installed."
  fi

  if pgrep -x waybar >/dev/null 2>&1; then
    pkill waybar
    echo "Waybar process stopped."
  fi

  if [[ -f "$target_config" ]]; then
    rm -f "$target_config"
    echo "Removed: $target_config"
  fi

  if [[ -f "$target_style" ]]; then
    rm -f "$target_style"
    echo "Removed: $target_style"
  fi

  if [[ -d "$target_dir" ]] && [[ -z "$(ls -A "$target_dir")" ]]; then
    rmdir "$target_dir"
    echo "Removed empty folder: $target_dir"
  fi

  if [[ "$is_installed" == true ]]; then
    echo "Waybar is installed. Removing waybar package..."
    sudo pacman -Rns waybar
    echo "Waybar uninstalled successfully."
  else
    echo "Skipping package removal because waybar is not installed."
  fi

  echo "Done."
}

uninstall_dunst() {
  echo "=== Uninstalling Dunst ==="
  local target_dir="$HOME/.config/dunst"
  local target_config="$target_dir/dunstrc"
  local is_installed=false

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if pacman -Q dunst >/dev/null 2>&1; then
    is_installed=true
    echo "Dunst is installed."
  else
    echo "Dunst is not installed."
  fi

  if pgrep -x dunst >/dev/null 2>&1; then
    pkill dunst
    echo "Dunst process stopped."
  fi

  if [[ -f "$target_config" ]]; then
    rm -f "$target_config"
    echo "Removed: $target_config"
  fi

  if [[ -d "$target_dir" ]] && [[ -z "$(ls -A "$target_dir")" ]]; then
    rmdir "$target_dir"
    echo "Removed empty folder: $target_dir"
  fi

  if [[ "$is_installed" == true ]]; then
    echo "Dunst is installed. Removing dunst package..."
    sudo pacman -Rns dunst
    echo "Dunst uninstalled successfully."
  else
    echo "Skipping package removal because dunst is not installed."
  fi

  echo "Done."
}

uninstall_fish() {
  echo "=== Uninstalling Fish ==="
  local target_dir="$HOME/.config/fish"
  local is_installed=false

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if pacman -Q fish >/dev/null 2>&1; then
    is_installed=true
    echo "Fish is installed."
  else
    echo "Fish is not installed."
  fi

  if [[ -d "$target_dir" ]]; then
    rm -f "$target_dir/config.fish"
    rm -f "$target_dir/env.fish"
    rm -f "$target_dir/fish_plugins"
    rm -rf "$target_dir/conf.d"
    rm -rf "$target_dir/functions"
    rm -rf "$target_dir/completions"

    echo "Removed Fish config files from: $target_dir"

    local remaining=$(ls -A "$target_dir" 2>/dev/null || true)
    if [[ -z "$remaining" ]]; then
      rmdir "$target_dir"
      echo "Removed empty folder: $target_dir"
    else
      echo "Preserved non-managed files: $remaining"
    fi
  fi

  if [[ "$is_installed" == true ]]; then
    echo "Fish is installed. Removing fish package..."
    sudo pacman -Rns fish
    echo "Fish uninstalled successfully."
  else
    echo "Skipping package removal because fish is not installed."
  fi

  echo "Done."
}

uninstall_kitty() {
  echo "=== Uninstalling Kitty ==="
  local target_dir="$HOME/.config/kitty"
  local is_installed=false

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if pacman -Q kitty >/dev/null 2>&1; then
    is_installed=true
    echo "Kitty is installed."
  else
    echo "Kitty is not installed."
  fi

  if pgrep -x kitty >/dev/null 2>&1; then
    echo "Stopping Kitty..."
    pkill kitty || true
  fi

  if [[ -d "$target_dir" ]]; then
    rm -f "$target_dir/kitty.conf"
    rm -f "$target_dir/theme.conf"
    rm -f "$target_dir/tabstyle.conf"
    rm -f "$target_dir/everblush-theme.conf"
    rm -f "$target_dir/tab_bar.py"

    echo "Removed Kitty config files from: $target_dir"

    local remaining=$(ls -A "$target_dir" 2>/dev/null || true)
    if [[ -z "$remaining" ]]; then
      rmdir "$target_dir"
      echo "Removed empty folder: $target_dir"
    else
      echo "Preserved non-managed files: $remaining"
    fi
  fi

  if [[ "$is_installed" == true ]]; then
    echo "Kitty is installed. Removing kitty package..."
    sudo pacman -Rns kitty
    echo "Kitty uninstalled successfully."
  else
    echo "Skipping package removal because kitty is not installed."
  fi

  echo "Done."
}

uninstall_neovim() {
  echo "=== Uninstalling Neovim ==="
  local target_dir="$HOME/.config/nvim"
  local is_installed=false

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if pacman -Q neovim >/dev/null 2>&1; then
    is_installed=true
    echo "Neovim is installed."
  else
    echo "Neovim is not installed."
  fi

  if [[ -d "$target_dir" ]]; then
    rm -rf "$target_dir/init.lua"
    rm -rf "$target_dir/lua"
    rm -rf "$target_dir/.luarc.json"
    rm -rf "$target_dir/.stylua.toml"
    rm -rf "$target_dir/lazy-lock.json"

    echo "Removed Neovim config files from: $target_dir"

    if [[ -z "$(ls -A "$target_dir")" ]]; then
      rmdir "$target_dir"
      echo "Removed empty folder: $target_dir"
    fi
  fi

  if [[ "$is_installed" == true ]]; then
    echo "Neovim is installed. Removing neovim package..."
    sudo pacman -Rns neovim
    echo "Neovim uninstalled successfully."
  else
    echo "Skipping package removal because neovim is not installed."
  fi

  echo "Done."
}

uninstall_nwgbar() {
  echo "=== Uninstalling Nwg-bar ==="
  local target_dir="$HOME/.config/nwg-bar"
  local is_installed=false

  if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is for Arch-based distros only (pacman not found)."
    exit 1
  fi

  if pacman -Q nwg-bar >/dev/null 2>&1; then
    is_installed=true
    echo "Nwg-bar is installed."
  else
    echo "Nwg-bar is not installed."
  fi

  if [[ -d "$target_dir" ]]; then
    rm -f "$target_dir/bar.json"
    rm -f "$target_dir/style.css"
    rm -rf "$target_dir/assets"

    echo "Removed Nwg-bar config files from: $target_dir"

    local remaining=$(ls -A "$target_dir" 2>/dev/null || true)
    if [[ -z "$remaining" ]]; then
      rmdir "$target_dir"
      echo "Removed empty folder: $target_dir"
    else
      echo "Preserved non-managed files: $remaining"
    fi
  fi

  if [[ "$is_installed" == true ]]; then
    echo "Nwg-bar is installed. Removing nwg-bar package..."
    sudo pacman -Rns nwg-bar
    echo "Nwg-bar uninstalled successfully."
  else
    echo "Skipping package removal because nwg-bar is not installed."
  fi

  echo "Done."
}

uninstall_starship() {
  echo "=== Uninstalling Starship ==="
  local target_dir="$HOME/.config/starship"
  local target_config="$target_dir/starship.toml"
  local is_installed=false

  if command -v starship >/dev/null 2>&1; then
    is_installed=true
    echo "Starship is installed."
  else
    echo "Starship is not installed."
  fi

  if [[ -f "$target_config" ]]; then
    rm -f "$target_config"
    echo "Removed: $target_config"
  fi

  if [[ -d "$target_dir" ]] && [[ -z "$(ls -A "$target_dir")" ]]; then
    rmdir "$target_dir"
    echo "Removed empty folder: $target_dir"
  fi

  if [[ "$is_installed" == true ]]; then
    echo ""
    echo "Starship package is still installed. To remove it:"
    if command -v pacman >/dev/null 2>&1; then
      echo "  sudo pacman -Rns starship"
    fi
    echo ""
    echo "Also remove the 'starship init' line from your shell config (~/.bashrc, ~/.zshrc, etc.)."
  fi

  echo "Done."
}

if [[ $# -eq 0 ]]; then
  usage
fi

for arg in "$@"; do
  case "${arg,,}" in
    all)
      uninstall_waybar
      uninstall_dunst
      uninstall_fish
      uninstall_kitty
      uninstall_neovim
      uninstall_nwgbar
      uninstall_starship
      ;;
    waybar) uninstall_waybar ;;
    dunst) uninstall_dunst ;;
    fish) uninstall_fish ;;
    kitty) uninstall_kitty ;;
    neovim) uninstall_neovim ;;
    nwgbar) uninstall_nwgbar ;;
    starship) uninstall_starship ;;
    *)
      echo "Unknown component: $arg"
      usage
      ;;
  esac
done
