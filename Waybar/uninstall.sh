#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="$HOME/.config/waybar"
TARGET_CONFIG="$TARGET_DIR/config.jsonc"
TARGET_STYLE="$TARGET_DIR/style.css"
IS_INSTALLED=false

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if pacman -Q waybar >/dev/null 2>&1; then
  IS_INSTALLED=true
  echo "Waybar is installed."
else
  echo "Waybar is not installed."
fi

if pgrep -x waybar >/dev/null 2>&1; then
  pkill waybar
  echo "Waybar process stopped."
fi

if [[ -f "$TARGET_CONFIG" ]]; then
  rm -f "$TARGET_CONFIG"
  echo "Removed: $TARGET_CONFIG"
fi

if [[ -f "$TARGET_STYLE" ]]; then
  rm -f "$TARGET_STYLE"
  echo "Removed: $TARGET_STYLE"
fi

if [[ -d "$TARGET_DIR" ]] && [[ -z "$(ls -A "$TARGET_DIR")" ]]; then
  rmdir "$TARGET_DIR"
  echo "Removed empty folder: $TARGET_DIR"
fi

if [[ "$IS_INSTALLED" == true ]]; then
  echo "Waybar is installed. Removing waybar package..."
  sudo pacman -Rns waybar
  echo "Waybar uninstalled successfully."
else
  echo "Skipping package removal because waybar is not installed."
fi

echo "Done."
