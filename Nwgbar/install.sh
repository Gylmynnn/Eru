#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_CONFIG="$SCRIPT_DIR/bar.json"
SRC_STYLE="$SCRIPT_DIR/style.css"
SRC_ASSETS="$SCRIPT_DIR/assets"
TARGET_DIR="$HOME/.config/nwg-bar"
TARGET_CONFIG="$TARGET_DIR/bar.json"
TARGET_STYLE="$TARGET_DIR/style.css"
TARGET_ASSETS="$TARGET_DIR/assets"

missing=false
for src in "$SRC_CONFIG" "$SRC_STYLE" "$SRC_ASSETS"; do
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

mkdir -p "$TARGET_DIR"

if [[ -f "$TARGET_CONFIG" || -f "$TARGET_STYLE" || -d "$TARGET_ASSETS" ]]; then
  BACKUP_DIR="$HOME/.config/nwg-bar.backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  [[ -f "$TARGET_CONFIG" ]] && cp "$TARGET_CONFIG" "$BACKUP_DIR/bar.json"
  [[ -f "$TARGET_STYLE" ]] && cp "$TARGET_STYLE" "$BACKUP_DIR/style.css"
  [[ -d "$TARGET_ASSETS" ]] && cp -r "$TARGET_ASSETS" "$BACKUP_DIR/"
  echo "Existing config backed up to: $BACKUP_DIR"
fi

cp "$SRC_CONFIG" "$TARGET_CONFIG"
cp "$SRC_STYLE" "$TARGET_STYLE"
cp -r "$SRC_ASSETS" "$TARGET_DIR/"

echo "Nwg-bar config installed at: $TARGET_DIR"
echo ""
echo "To launch the power menu, run:"
echo "  nwg-bar"
echo ""
echo "Or bind it to a keyboard shortcut in your Hyprland config:"
echo "  bind = \$mainMod, Escape, exec, nwg-bar"

echo "Done."
