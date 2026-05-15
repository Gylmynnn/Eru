#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="$HOME/.config/starship"
TARGET_CONFIG="$TARGET_DIR/starship.toml"
IS_INSTALLED=false

if command -v starship >/dev/null 2>&1; then
  IS_INSTALLED=true
  echo "Starship is installed."
else
  echo "Starship is not installed."
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
  echo ""
  echo "Starship package is still installed. To remove it:"
  if command -v pacman >/dev/null 2>&1; then
    echo "  sudo pacman -Rns starship"
  fi
  echo ""
  echo "Also remove the 'starship init' line from your shell config (~/.bashrc, ~/.zshrc, etc.)."
fi

echo "Done."
