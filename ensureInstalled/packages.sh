#!/usr/bin/env bash

nonvmshit="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")/gui.sh"

packages=(
    fastfetch
    fzf
    lazygit
    neovim
    ripgrep
    tmux
    yazi
    superfile
    zsh
    greetd
    tuigreet
    zoxide
    starship
    github-cli
    glab
    wget
    btop
    7zip
    unzip
    zip
    lsd
)
(dmidecode -s system-manufacturer || sudo dmidecode -s system-manufacturer) | grep -qEi 'qemu' || source "$nonvmshit"

grep -qEi 'arch' /etc/os-release && packages+=(reflector)
