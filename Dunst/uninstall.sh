#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="$HOME/.config/dunst"
TARGET_CONFIG="$TARGET_DIR/dunstrc"
IS_INSTALLED=false

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if pacman -Q dunst >/dev/null 2>&1; then
  IS_INSTALLED=true
  echo "Dunst is installed."
else
  echo "Dunst is not installed."
fi

if pgrep -x dunst >/dev/null 2>&1; then
  pkill dunst
  echo "Dunst process stopped."
fi

if [[ -f "$TARGET_CONFIG" ]]; then
  rm -f "$TARGET_CONFIG"
  echo "Removed: $TARGET_CONFIG"
fi

if [[ -d "$TARGET_DIR" ]] && [[ -z "$(ls -A "$TARGET_DIR")" ]]; then
  rmdir "$TARGET_DIR"
  echo "Removed empty folder: $TARGET_DIR"
fi

if [[ "$IS_INSTALLED" == true ]]; then
  echo "Dunst is installed. Removing dunst package..."
  sudo pacman -Rns dunst
  echo "Dunst uninstalled successfully."
else
  echo "Skipping package removal because dunst is not installed."
fi

echo "Done."
