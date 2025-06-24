#!/usr/bin/env sh

waybar="$1"

swww-daemon\
    &
swaync\
    &
eval "$waybar"\
    &
sudo $HOME/.config/shitbox/scripts/automount.sh\
    &

export GTK_THEME=Sweet-Dark
