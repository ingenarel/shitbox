#!/usr/bin/env bash

declare -A menusAndCommands=(
    ["⏻ Shutdown"]="systemctl poweroff"
    [" Reboot"]="systemctl reboot"
    ["󰤄 Suspend"]="systemctl suspend"
    ["󰿅 Logout"]="hyprctl dispatch exit 1"
    ["󰷛 LockScreen"]="hyprlock"
)

chosen=$(echo -en "$( for item in "${!menusAndCommands[@]}"; do echo -n "$item" "\n"; done)" |
    if command -v fuzzel > /dev/null 2>&1; then
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
    elif command -v tofi > /dev/null 2>&1; then
        tofi\
            --height 20%\
            --width 15%\
            --font "$HOME/.local/share/fonts/HackNerdFont-Regular.ttf"\
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
    fi
)

${menusAndCommands["$chosen"]}
