set -g fish_greeting
starship init fish | source

# LS aliases
alias l='eza -lh  --icons=auto'
alias ls='eza   --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# Utility aliases
alias :venv='source .venv/bin/activate.fish'
alias :update='sudo pacman -Syu'
alias :mirror='sudo reflector --verbose --latest 5 --country "United States" --age 6 --sort rate --save /etc/pacman.d/mirrorlist'
alias :trash='sudo du -sh /var/cache/pacman/pkg/'
alias vim='nvim'
alias g='git'
alias :t="pomodoro work"
alias :b="pomodoro break"
alias :ff="fzfv"
alias :fa="fzfcd"
alias :app='cd /home/ligichi/Documents/Program/'
alias :dot='cd /home/ligichi/Dotfiles/'

# Navigation
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Git
abbr gcb 'git checkout -b'
abbr gc 'git checkout'

# System
abbr :q 'exit'
abbr :hd 'cd /home/ligichi/'
abbr :cf 'cd ~/.config'
abbr :nvim 'cd ~/.config/nvim && nvim'
abbr :fish 'cd ~/.config/fish && nvim'
abbr :kitty 'cd ~/.config/kitty && nvim'
abbr :waybar 'cd ~/.config/waybar && nvim'
abbr :hypr 'cd ~/.config/hypr && nvim'
abbr :audio 'pactl list sources | grep -A 15 "Source #"'
abbr :free 'sudo du -h --max-depth=1 ~ | sort -hr'
abbr :volume 'systemctl --user restart pipewire pipewire-pulse wireplumber'
abbr mkdir 'mkdir -p'

# Docker
abbr :dils 'docker images'
abbr :dcls 'docker ps -a'
abbr :startd 'systemctl start docker'
abbr :stopd 'systemctl stop docker.socket'
abbr :di 'docker version'

# PATH: Bun
set -x BUN_INSTALL $HOME/.bun
set -x PATH $BUN_INSTALL/bin $PATH

# PATH: Herd / PHP
set -x PATH /home/ligichi/.config/herd-lite/bin $PATH
set -x PHP_INI_SCAN_DIR /home/ligichi/.config/herd-lite/bin $PHP_INI_SCAN_DIR

# PATH: Android / Java
set -x ANDROID_HOME $HOME/Android/Sdk
set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk
set -x PATH $JAVA_HOME/bin $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools $PATH

# PATH: Go
set -U fish_user_paths (go env GOPATH)/bin $fish_user_paths

# PATH: Misc
set -x PATH $PATH $HOME/.pub-cache/bin
set -x PATH /home/ligichi/bin $PATH
set PATH $PATH /home/ligichi/.local/bin
fish_add_path /home/ligichi/.spicetify

# PATH: Cargo / opencode
set -gx PATH /home/ligichi/.cargo/bin $PATH
fish_add_path /home/ligichi/.opencode/bin

# PATH: Android extras
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin
set -x PATH $PATH $ANDROID_HOME/platform-tools
set -x PATH $PATH $ANDROID_HOME/emulator

# pnpm
set -gx PNPM_HOME "/home/ligichi/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

source ~/.config/fish/env.fish
