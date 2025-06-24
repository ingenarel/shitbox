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

gsettings set org.gnome.desktop.interface gtk-theme Sweet-Dark
