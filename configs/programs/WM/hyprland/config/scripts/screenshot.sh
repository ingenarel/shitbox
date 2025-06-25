#!/usr/bin/env bash

grim -t ppm -\
    |
satty\
    --fullscreen\
    --actions-on-escape save-to-clipboard,exit\
    --copy-command wl-copy\
    --disable-notifications\
    --filename -\
    --output-filename "$HOME/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png"
