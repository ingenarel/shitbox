#!/usr/bin/env bash

declare -A menusAndCommands=(
    ["⏻ Shutdown"]="systemctl poweroff"
    [" Reboot"]="systemctl reboot"
    ["󰤄 Suspend"]="systemctl suspend"
    ["󰿅 Logout"]="hyprctl dispatch exit 1"
    ["󰷛 LockScreen"]="hyprlock"
)

chosen=$(echo -en $( for item in "${!menusAndCommands[@]}"; do echo -n $item "\n"; done) |
    fuzzel\
        --dmenu\
        --lines 5\
        --width 15\
        --tabs 4\
        --background \#110015e6\
        --text-color \#EE70FFff\
        --font 'Hack Nerd Font:size=15'\
        --border-color \#ff00ffff\
        --selection-color \#420080ff\
        --border-width 2\
        --border-radius 15\
        |
    sed 's/.$//'
)

${menusAndCommands["$chosen"]}
