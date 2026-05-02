#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_INIT="$SCRIPT_DIR/init.lua"
SRC_LUA="$SCRIPT_DIR/lua"
SRC_LUARC="$SCRIPT_DIR/.luarc.json"
SRC_STYLUA="$SCRIPT_DIR/.stylua.toml"
SRC_LAZY_LOCK="$SCRIPT_DIR/lazy-lock.json"
TARGET_DIR="$HOME/.config/nvim"

if [[ ! -f "$SRC_INIT" || ! -d "$SRC_LUA" ]]; then
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

mkdir -p "$TARGET_DIR"

if [[ -f "$TARGET_DIR/init.lua" || -d "$TARGET_DIR/lua" ]]; then
  BACKUP_DIR="$HOME/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  [[ -f "$TARGET_DIR/init.lua" ]] && cp "$TARGET_DIR/init.lua" "$BACKUP_DIR/init.lua"
  [[ -d "$TARGET_DIR/lua" ]] && cp -r "$TARGET_DIR/lua" "$BACKUP_DIR/"
  [[ -f "$TARGET_DIR/.luarc.json" ]] && cp "$TARGET_DIR/.luarc.json" "$BACKUP_DIR/.luarc.json"
  [[ -f "$TARGET_DIR/.stylua.toml" ]] && cp "$TARGET_DIR/.stylua.toml" "$BACKUP_DIR/.stylua.toml"
  [[ -f "$TARGET_DIR/lazy-lock.json" ]] && cp "$TARGET_DIR/lazy-lock.json" "$BACKUP_DIR/lazy-lock.json"
  echo "Existing config backed up to: $BACKUP_DIR"
fi

cp "$SRC_INIT" "$TARGET_DIR/init.lua"
cp -r "$SRC_LUA" "$TARGET_DIR/"
[[ -f "$SRC_LUARC" ]] && cp "$SRC_LUARC" "$TARGET_DIR/.luarc.json"
[[ -f "$SRC_STYLUA" ]] && cp "$SRC_STYLUA" "$TARGET_DIR/.stylua.toml"
[[ -f "$SRC_LAZY_LOCK" ]] && cp "$SRC_LAZY_LOCK" "$TARGET_DIR/lazy-lock.json"

echo "Neovim config installed at: $TARGET_DIR"
echo ""
echo "Run 'nvim' to start Neovim. On first run, it will automatically:"
echo "  - Install lazy.nvim plugin manager"
echo "  - Download and setup all plugins"
echo "  - Install LSP servers and tools"
echo ""
echo "Done."
