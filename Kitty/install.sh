#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_CONFIGS=(
  "$SCRIPT_DIR/kitty.conf"
  "$SCRIPT_DIR/theme.conf"
  "$SCRIPT_DIR/tabstyle.conf"
  "$SCRIPT_DIR/everblush-theme.conf"
  "$SCRIPT_DIR/tab_bar.py"
)
TARGET_DIR="$HOME/.config/kitty"

missing=false
for src in "${SRC_CONFIGS[@]}"; do
  if [[ ! -e "$src" ]]; then
    echo "Missing: $src"
    missing=true
  fi
done
if [[ "$missing" == true ]]; then
  echo "Source config files were not found in the Kitty folder."
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if ! pacman -Q kitty >/dev/null 2>&1; then
  echo "Kitty is not installed. Installing kitty..."
  sudo pacman -S --needed kitty
else
  echo "Kitty is already installed."
fi

mkdir -p "$TARGET_DIR"

if [[ -f "$TARGET_DIR/kitty.conf" ]] || [[ -f "$TARGET_DIR/theme.conf" ]] || [[ -f "$TARGET_DIR/tabstyle.conf" ]]; then
  BACKUP_DIR="$HOME/.config/kitty.backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  [[ -f "$TARGET_DIR/kitty.conf" ]] && cp "$TARGET_DIR/kitty.conf" "$BACKUP_DIR/kitty.conf"
  [[ -f "$TARGET_DIR/theme.conf" ]] && cp "$TARGET_DIR/theme.conf" "$BACKUP_DIR/theme.conf"
  [[ -f "$TARGET_DIR/tabstyle.conf" ]] && cp "$TARGET_DIR/tabstyle.conf" "$BACKUP_DIR/tabstyle.conf"
  [[ -f "$TARGET_DIR/everblush-theme.conf" ]] && cp "$TARGET_DIR/everblush-theme.conf" "$BACKUP_DIR/everblush-theme.conf"
  [[ -f "$TARGET_DIR/tab_bar.py" ]] && cp "$TARGET_DIR/tab_bar.py" "$BACKUP_DIR/tab_bar.py"
  echo "Existing config backed up to: $BACKUP_DIR"
fi

cp "$SCRIPT_DIR/kitty.conf" "$TARGET_DIR/kitty.conf"
cp "$SCRIPT_DIR/theme.conf" "$TARGET_DIR/theme.conf"
cp "$SCRIPT_DIR/tabstyle.conf" "$TARGET_DIR/tabstyle.conf"
cp "$SCRIPT_DIR/everblush-theme.conf" "$TARGET_DIR/everblush-theme.conf"
cp "$SCRIPT_DIR/tab_bar.py" "$TARGET_DIR/tab_bar.py"

echo "Kitty config installed at: $TARGET_DIR"

if pgrep -x kitty >/dev/null 2>&1; then
  echo ""
  echo "Kitty is currently running. Restart Kitty for changes to take effect:"
  echo "  pkill kitty"
  echo "  kitty &"
else
  echo ""
  echo "To launch Kitty, run:"
  echo "  kitty"
fi

echo "Done."
