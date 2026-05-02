#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="$HOME/.config/nvim"
IS_INSTALLED=false

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if pacman -Q neovim >/dev/null 2>&1; then
  IS_INSTALLED=true
  echo "Neovim is installed."
else
  echo "Neovim is not installed."
fi

if [[ -d "$TARGET_DIR" ]]; then
  # Remove config files
  rm -rf "$TARGET_DIR/init.lua"
  rm -rf "$TARGET_DIR/lua"
  rm -rf "$TARGET_DIR/.luarc.json"
  rm -rf "$TARGET_DIR/.stylua.toml"
  rm -rf "$TARGET_DIR/lazy-lock.json"
  
  echo "Removed Neovim config files from: $TARGET_DIR"

  if [[ -z "$(ls -A "$TARGET_DIR")" ]]; then
    rmdir "$TARGET_DIR"
    echo "Removed empty folder: $TARGET_DIR"
  fi
fi

if [[ "$IS_INSTALLED" == true ]]; then
  echo "Neovim is installed. Removing neovim package..."
  sudo pacman -Rns neovim
  echo "Neovim uninstalled successfully."
else
  echo "Skipping package removal because neovim is not installed."
fi

echo "Done."
