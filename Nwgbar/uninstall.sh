#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="$HOME/.config/nwg-bar"
IS_INSTALLED=false

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if pacman -Q nwg-bar >/dev/null 2>&1; then
  IS_INSTALLED=true
  echo "Nwg-bar is installed."
else
  echo "Nwg-bar is not installed."
fi

if [[ -d "$TARGET_DIR" ]]; then
  rm -f "$TARGET_DIR/bar.json"
  rm -f "$TARGET_DIR/style.css"
  rm -rf "$TARGET_DIR/assets"

  echo "Removed Nwg-bar config files from: $TARGET_DIR"

  remaining=$(ls -A "$TARGET_DIR" 2>/dev/null || true)
  if [[ -z "$remaining" ]]; then
    rmdir "$TARGET_DIR"
    echo "Removed empty folder: $TARGET_DIR"
  else
    echo "Preserved non-managed files: $remaining"
  fi
fi

if [[ "$IS_INSTALLED" == true ]]; then
  echo "Nwg-bar is installed. Removing nwg-bar package..."
  sudo pacman -Rns nwg-bar
  echo "Nwg-bar uninstalled successfully."
else
  echo "Skipping package removal because nwg-bar is not installed."
fi

echo "Done."
