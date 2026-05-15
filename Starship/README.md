# Starship Dotfiles

Starship prompt configuration.

## Folder Contents

- `starship.toml` - Starship configuration (palette, modules, formatting).

## Features

- Custom Everblush color palette.
- Username and hostname display.
- Directory truncation with repository detection.
- Language-specific modules (Python, Node.js, Rust, Go, Dart, etc.).
- Docker context detection with `docker-compose.yml` and `Dockerfile`.
- Command duration display.
- Conda environment support.

## Dependencies

Minimum:

- `starship`

Optional (used by this config):

- Nerd Font (example: `JetBrainsMono Nerd Font`) for icons

## Installation

```bash
mkdir -p ~/.config/starship
cp Starship/starship.toml ~/.config/starship/starship.toml
```

Add the following to your shell's config file (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
eval "$(starship init bash)"
```

## Uninstall

```bash
rm ~/.config/starship/starship.toml
```

Remove the `starship init` line from your shell's config file.

## Quick Customization

- Change the color palette under `[palettes.everblush]`.
- Toggle or configure language modules in their respective sections.
- Adjust directory truncation length in `[directory]`.
- Enable/disable modules by setting `disabled = true/false`.
