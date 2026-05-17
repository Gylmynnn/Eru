#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_CONFIGS=(
  "$SCRIPT_DIR/config.fish"
  "$SCRIPT_DIR/env.fish"
  "$SCRIPT_DIR/fish_plugins"
  "$SCRIPT_DIR/conf.d"
  "$SCRIPT_DIR/functions"
  "$SCRIPT_DIR/completions"
)
TARGET_DIR="$HOME/.config/fish"

missing=false
for src in "${SRC_CONFIGS[@]}"; do
  if [[ ! -e "$src" ]]; then
    echo "Missing: $src"
    missing=true
  fi
done
if [[ "$missing" == true ]]; then
  echo "Source config files were not found in the Fish folder."
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "This script is for Arch-based distros only (pacman not found)."
  exit 1
fi

if ! pacman -Q fish >/dev/null 2>&1; then
  echo "Fish is not installed. Installing fish..."
  sudo pacman -S --needed fish
else
  echo "Fish is already installed."
fi

mkdir -p "$TARGET_DIR"

if [[ -d "$TARGET_DIR" ]] && ls -A "$TARGET_DIR" | grep -qv '^fish_variables$'; then
  BACKUP_DIR="$HOME/.config/fish.backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  for item in "$TARGET_DIR"/*; do
    name="$(basename "$item")"
    [[ "$name" == "fish_variables" ]] && continue
    cp -r "$item" "$BACKUP_DIR/"
  done
  echo "Existing config backed up to: $BACKUP_DIR"
fi

cp "$SCRIPT_DIR/config.fish" "$TARGET_DIR/config.fish"
cp "$SCRIPT_DIR/env.fish" "$TARGET_DIR/env.fish"
cp "$SCRIPT_DIR/fish_plugins" "$TARGET_DIR/fish_plugins"
cp -r "$SCRIPT_DIR/conf.d" "$TARGET_DIR/"
cp -r "$SCRIPT_DIR/functions" "$TARGET_DIR/"
cp -r "$SCRIPT_DIR/completions" "$TARGET_DIR/"

echo "Fish config installed at: $TARGET_DIR"

if command -v fish >/dev/null 2>&1; then
  echo ""
  echo "To install fisher and plugins, run:"
  echo "  fish -c 'fisher update'"
fi

echo "Done."
