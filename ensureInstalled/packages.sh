#!/usr/bin/env bash

nonvmshit="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")/gui.sh"

packages=(
    fastfetch
    fzf
    lazygit
    neovim
    ripgrep
    fd
    tmux
    zellij
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
    inotify-tools
    perl
    diskonaut
)

grep -qi 'gentoo' /etc/os-release && {
    packages+=(
        genlop
        app-portage/smart-live-rebuild
        app-portage/eix
        dev-util/pkgdev
    )
}

(dmidecode -s system-manufacturer || sudo dmidecode -s system-manufacturer) | grep -qEi 'qemu' || source "$nonvmshit"

grep -qEi 'arch' /etc/os-release && packages+=(reflector)
