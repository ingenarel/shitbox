#!/usr/bin/env bash

if grep -qEi "nixos" /etc/os-release ; then
    nix-collect-garbage -d
    sudo nix-collect-garbage -d
elif grep -qEi "gentoo" /etc/os-release ; then
    sudo emerge --deep --depclean
elif grep -qEi "arch" /etc/os-release ; then
    paru -Qtdq | paru -Rns -
    paru -Sccd
fi
sudo rm -rf\
    "$HOME/.cargo"\
    "$HOME/.npm"\
    "$HOME/.local/share/Trash"\
    "$HOME/go"\
    "$HOME/.java"\
    /var/cache/*\
    "$HOME/.local/state/nvim/"*"log"

find "$HOME/.cache/" -maxdepth 1\
    |
sed -E "/(.+(keepassxc|weechat|swww|fuzzel|lutris-manager-names|tealdeer)|${HOME//\//\\/}\\/.cache\\/)$/d"\
    |
xargs --delimiter '\n' rm -rf
