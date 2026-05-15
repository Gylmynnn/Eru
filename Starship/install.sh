#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_CONFIG="$SCRIPT_DIR/starship.toml"
TARGET_DIR="$HOME/.config/starship"
TARGET_CONFIG="$TARGET_DIR/starship.toml"

if [[ ! -f "$SRC_CONFIG" ]]; then
  echo "Source starship.toml was not found in the Starship folder."
  exit 1
fi

if ! command -v starship >/dev/null 2>&1; then
  echo "Starship is not installed. Installing starship..."
  if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed starship
  elif command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
  else
    echo "Please install starship manually: https://starship.rs"
    exit 1
  fi
else
  echo "Starship is already installed."
fi

mkdir -p "$TARGET_DIR"

if [[ -f "$TARGET_CONFIG" ]]; then
  BACKUP_DIR="$HOME/.config/starship.backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  cp "$TARGET_CONFIG" "$BACKUP_DIR/starship.toml"
  echo "Existing config backed up to: $BACKUP_DIR"
fi

cp "$SRC_CONFIG" "$TARGET_CONFIG"
echo "Starship config installed at: $TARGET_CONFIG"
echo ""
echo "Add the following to your shell config (~/.bashrc, ~/.zshrc, etc.):"
echo '  eval "$(starship init bash)"'
echo "Done."
