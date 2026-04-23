# Waybar Dotfiles

Konfigurasi Waybar untuk lingkungan Hyprland.

## Preview

![Waybar preview](waybar.png)

## Isi folder

- `config.jsonc` - konfigurasi modul, layout, action klik, dan command modul custom.
- `style.css` - styling Waybar (warna, padding, radius, font, dan ukuran icon).
- `waybar.png` - screenshot tampilan.

## Fitur

- Posisi bar di bawah layar dengan layout kiri/tengah/kanan.
- Workspace indicator untuk Hyprland.
- Launcher cepat (Kitty, Thunar, VS Code, Min browser).
- Info sistem (CPU, memory, battery, volume, backlight, tray).
- Clock + kalender popup via `waycal`.
- Modul custom seperti `cpucat` dan visualizer `cava`.

## Dependensi

Minimum:

- `waybar`
- `hyprland`
- Nerd Font (contoh: `JetBrainsMono Nerd Font`)

Tambahan (dipakai oleh beberapa modul):

- `playerctl`
- `spotifatius`
- `waycal`
- `brightnessctl`
- `pavucontrol`
- `swaync` (`swaync-client`)
- `kitty`, `thunar`, `code`, `min-browser`

Script lokal yang direferensikan:

- `~/scripts/catloop.sh`
- `~/.config/waybar/custom-scripts/cava.sh`
- `logoutlaunch.sh`

## Instalasi

```bash
mkdir -p ~/.config/waybar
cp Waybar/config.jsonc ~/.config/waybar/config.jsonc
cp Waybar/style.css ~/.config/waybar/style.css
```

Restart Waybar:

```bash
pkill waybar
waybar &
```

## Kustomisasi cepat

- Ganti command launcher di `config.jsonc` bagian `on-click`.
- Sesuaikan warna/spacing di `style.css`.
- Jika path script beda, ubah path script custom pada `config.jsonc`.
