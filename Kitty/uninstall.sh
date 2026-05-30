#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="$HOME/.config/kitty"
IS_INSTALLED=false

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if pacman -Q kitty >/dev/null 2>&1; then
  IS_INSTALLED=true
  echo "Kitty is installed."
else
  echo "Kitty is not installed."
fi

if pgrep -x kitty >/dev/null 2>&1; then
  echo "Stopping Kitty..."
  pkill kitty || true
fi

if [[ -d "$TARGET_DIR" ]]; then
  rm -f "$TARGET_DIR/kitty.conf"
  rm -f "$TARGET_DIR/theme.conf"
  rm -f "$TARGET_DIR/tabstyle.conf"
  rm -f "$TARGET_DIR/everblush-theme.conf"
  rm -f "$TARGET_DIR/tab_bar.py"

  echo "Removed Kitty config files from: $TARGET_DIR"

  remaining=$(ls -A "$TARGET_DIR" 2>/dev/null || true)
  if [[ -z "$remaining" ]]; then
    rmdir "$TARGET_DIR"
    echo "Removed empty folder: $TARGET_DIR"
  else
    echo "Preserved non-managed files: $remaining"
  fi
fi

if [[ "$IS_INSTALLED" == true ]]; then
  echo "Kitty is installed. Removing kitty package..."
  sudo pacman -Rns kitty
  echo "Kitty uninstalled successfully."
else
  echo "Skipping package removal because kitty is not installed."
fi

echo "Done."
