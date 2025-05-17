#!/usr/bin/env bash

if grep -qEi "nixos" /etc/os-release ; then
    nix-collect-garbage -d
    sudo nix-collect-garbage -d
fi
sudo rm -rf "$HOME/.cache/*" "$HOME/.cargo" "$HOME/.npm" "$HOME/.local/share/Trash"
