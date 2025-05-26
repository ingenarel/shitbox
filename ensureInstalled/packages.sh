#!/usr/bin/env bash

guiScriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")/gui.sh"

packages=(
    fastfetch
    fzf
    lazygit
    neovim
    ripgrep
    tmux
    yazi
    zsh
    greetd
    tuigreet
    zoxide
    starship
)
(dmidecode -s system-manufacturer || sudo dmidecode -s system-manufacturer) | grep -qEi 'qemu' || source "$guiScriptDir"
