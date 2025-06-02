#!/usr/bin/env bash

res="$(
    for shit in /sys/class/drm/card*-*/; do
        [[ -f "$shit/status" && "$(< "$shit/status")" == "connected" ]] && { head -n1 "$shit/modes" && break; }
    done
)"

echo "$res"

grim -g "0,0 $res" -t ppm -\
    |
satty\
    --fullscreen\
    --actions-on-escape save-to-clipboard,exit\
    --copy-command wl-copy\
    --disable-notifications\
    --filename -\
    --output-filename "$HOME/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png"
