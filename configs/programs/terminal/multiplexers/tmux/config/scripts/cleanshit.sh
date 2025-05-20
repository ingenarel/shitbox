#!/usr/bin/env bash

if grep -qEi "nixos" /etc/os-release ; then
    nix-collect-garbage -d
    sudo nix-collect-garbage -d
elif grep -qEi "gentoo" /etc/os-release ; then
    sudo emerge --deep --depclean
    sudo rm -rf /var/cache/binpkgs/* /var/cache/distfiles/*
fi
sudo rm -rf "$HOME/.cache/*" "$HOME/.cargo" "$HOME/.npm" "$HOME/.local/share/Trash"
