#!/usr/bin/env bash

declare -A menusAndCommands=(
    ["⏻ Shutdown"]="systemctl poweroff"
    [" Reboot"]="systemctl reboot"
    ["󰤄 Suspend"]="systemctl suspend"
    ["󰿅 Logout"]="hyprctl dispatch exit 1"
    ["󰷛 LockScreen"]="hyprlock"
)

chosen=$(echo -e $( for item in "${!menusAndCommands[@]}"; do echo -n $item "\n"; done) |\
        tofi\
        --height 20%\
        --width 15%\
        --font /home/ingenarel/.local/share/fonts/HackNerdFont-Regular.ttf\
        --font-size 15\
        --background \#110015e6\
        --text-color \#EE70FFff\
        --border-color \#ff00ffff\
        --selection-background \#420080ff\
        --text-cursor true\
        --fuzzy-match true\
        --border-width 2\
        --outline-width 0\
        --corner-radius 15\
        --prompt-text ""|\
        sed 's/.$//'
)
${menusAndCommands["$chosen"]}
