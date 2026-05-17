#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="$HOME/.config/fish"
IS_INSTALLED=false

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if pacman -Q fish >/dev/null 2>&1; then
  IS_INSTALLED=true
  echo "Fish is installed."
else
  echo "Fish is not installed."
fi

if [[ -d "$TARGET_DIR" ]]; then
  rm -f "$TARGET_DIR/config.fish"
  rm -f "$TARGET_DIR/env.fish"
  rm -f "$TARGET_DIR/fish_plugins"
  rm -rf "$TARGET_DIR/conf.d"
  rm -rf "$TARGET_DIR/functions"
  rm -rf "$TARGET_DIR/completions"

  echo "Removed Fish config files from: $TARGET_DIR"

  remaining=$(ls -A "$TARGET_DIR" 2>/dev/null || true)
  if [[ -z "$remaining" ]]; then
    rmdir "$TARGET_DIR"
    echo "Removed empty folder: $TARGET_DIR"
  else
    echo "Preserved non-managed files: $remaining"
  fi
fi

if [[ "$IS_INSTALLED" == true ]]; then
  echo "Fish is installed. Removing fish package..."
  sudo pacman -Rns fish
  echo "Fish uninstalled successfully."
else
  echo "Skipping package removal because fish is not installed."
fi

echo "Done."
