#!/usr/bin/env sh

if command -v flameshot; then
    flameshot gui
else
    grim -g "$(slurp)" - | wl-copy
fi
