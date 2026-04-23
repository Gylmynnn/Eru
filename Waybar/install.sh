#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_CONFIG="$SCRIPT_DIR/config.jsonc"
SRC_STYLE="$SCRIPT_DIR/style.css"
TARGET_DIR="$HOME/.config/waybar"
TARGET_CONFIG="$TARGET_DIR/config.jsonc"
TARGET_STYLE="$TARGET_DIR/style.css"

if [[ ! -f "$SRC_CONFIG" || ! -f "$SRC_STYLE" ]]; then
  echo "Source config files were not found in the Waybar folder."
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if ! pacman -Q waybar >/dev/null 2>&1; then
  echo "Waybar is not installed. Installing waybar..."
  sudo pacman -S --needed waybar
else
  echo "Waybar is already installed."
fi

mkdir -p "$TARGET_DIR"

if [[ -f "$TARGET_CONFIG" || -f "$TARGET_STYLE" ]]; then
  BACKUP_DIR="$HOME/.config/waybar.backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  [[ -f "$TARGET_CONFIG" ]] && cp "$TARGET_CONFIG" "$BACKUP_DIR/config.jsonc"
  [[ -f "$TARGET_STYLE" ]] && cp "$TARGET_STYLE" "$BACKUP_DIR/style.css"
  echo "Existing config backed up to: $BACKUP_DIR"
fi

cp "$SRC_CONFIG" "$TARGET_CONFIG"
cp "$SRC_STYLE" "$TARGET_STYLE"

echo "Waybar config installed at: $TARGET_DIR"

if pgrep -x waybar >/dev/null 2>&1; then
  pkill waybar
  nohup waybar >/dev/null 2>&1 &
  echo "Waybar restarted."
else
  echo "Waybar is not running. Start it manually with: waybar"
fi

echo "Done."
