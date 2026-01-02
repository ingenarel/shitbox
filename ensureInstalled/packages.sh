#!/usr/bin/env bash

nonvmshit="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")/gui.sh"

packages=(
    fastfetch
    fzf
    lazygit
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
    iamb
    weechat
    hunspell
    tinyxxd
    # soju
    bat
    git-delta
    tealdeer
    task
    torsocks
    sherlock
    rclone
    rustup
    man-pages
    wgetpaste
    zpaq
    sshfs
    gitleaks
)

packages+=(
    aerc
    glow
    chawan
)

packages+=(
    neovim
    ast-grep
)

{ dmidecode -s system-manufacturer || sudo dmidecode -s system-manufacturer; } | grep -qEi 'qemu' || {
    source "$nonvmshit"
    grep -qiE 'arch' /etc/os-release && {
        grep -qiE 'vendor_id\s*:\s*\S*intel' /proc/cpuinfo && {
            packages+=(
                vulkan-intel
                lib32-vulkan-intel
                vulkan-icd-loader
                lib32-vulkan-icd-loader
            )
        }
    }
}

grep -qEi 'arch' /etc/os-release && packages+=(reflector)
