#!/usr/bin/env sh

while true; do
    inotifywait -e close_write,modify "$HOME/.config/shitbox/configs/programs/WM/sway/config"
    swaymsg reload
done
