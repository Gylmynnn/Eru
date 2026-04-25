#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_CONFIG="$SCRIPT_DIR/dunstrc"
TARGET_DIR="$HOME/.config/dunst"
TARGET_CONFIG="$TARGET_DIR/dunstrc"

if [[ ! -f "$SRC_CONFIG" ]]; then
  echo "Source dunstrc was not found in the Dunst folder."
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if ! pacman -Q dunst >/dev/null 2>&1; then
  echo "Dunst is not installed. Installing dunst..."
  sudo pacman -S --needed dunst libnotify
else
  echo "Dunst is already installed."
fi

mkdir -p "$TARGET_DIR"

if [[ -f "$TARGET_CONFIG" ]]; then
  BACKUP_DIR="$HOME/.config/dunst.backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  cp "$TARGET_CONFIG" "$BACKUP_DIR/dunstrc"
  echo "Existing config backed up to: $BACKUP_DIR"
fi

cp "$SRC_CONFIG" "$TARGET_CONFIG"
echo "Dunst config installed at: $TARGET_DIR"

if pgrep -x dunst >/dev/null 2>&1; then
  pkill dunst
  nohup dunst >/dev/null 2>&1 &
  echo "Dunst restarted."
else
  echo "Dunst is not running. Start it manually with: dunst"
fi

echo "Done."
