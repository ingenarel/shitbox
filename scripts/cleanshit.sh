#!/usr/bin/env bash

if grep -qEi "nixos" /etc/os-release ; then
    nix-collect-garbage -d
    sudo nix-collect-garbage -d
elif grep -qEi "gentoo" /etc/os-release ; then
    sudo emerge --deep --depclean
elif grep -qEi "arch" /etc/os-release ; then
    pacman -Qtdq | sudo pacman -Rns -
    sudo paru -Sccd
fi
sudo rm -rf\
    "$HOME/.cargo"\
    "$HOME/.npm"\
    "$HOME/.java"\
    "$HOME/.gradle"\
    "$HOME/.nimble"\
    "$HOME/.local/share/Trash"\
    "$HOME/go"\
    "$HOME/.local/state/nvim/"*"log"

find "$HOME/.cache/" -maxdepth 1\
    |
sed -E "/(.+(keepassxc|weechat|swww|fuzzel|lutris-manager-names|tealdeer)|${HOME//\//\\/}\\/.cache\\/)$/d"\
    |
xargs --delimiter '\n' rm -rf
