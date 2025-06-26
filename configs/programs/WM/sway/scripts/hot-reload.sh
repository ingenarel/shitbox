#!/usr/bin/env sh

while true; do
    inotifywait -e close,modify "$HOME/.config/shitbox/configs/programs/WM/sway/config"
    swaymsg reload
done
