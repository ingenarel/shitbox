#!/usr/bin/env bash

if [[ $(hyprctl activewindow | grep tmux) ]]; then
    tmux new-window "$2";
else
    if [[ $3 ]]; then
        $1 -c $3 -e $2;
    else
        $1 -e $2;
    fi
fi
