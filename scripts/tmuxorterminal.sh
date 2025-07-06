#!/usr/bin/env bash

#@formatter:off

# [[ ( -n "$HYPRLAND_INSTANCE_SIGNATURE" && $(hyprctl activewindow | grep -q tmux) ) || ( -n $SWAYSOCK &&   )  ]]

# shellcheck disable=SC2015
tmux list-sessions > /dev/null 2>&1 && {
    tmux new-window "$2"
} || {
    [[ -n "$3" ]] && {
        "$1" -c "$3" -e "$2"
    } || {
        "$1" -e "$2"
    }
}
