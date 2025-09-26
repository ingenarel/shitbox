#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

if [[ $(tmux list-sessions) ]]; then
    tmux new-window "$scriptDir/launch.sh"
elif [[ "$TERM" != "linux" ]]; then
    "$scriptDir/launch.sh"
else
    #TODO: add options to disable status and shit
    kitty tmux -f /dev/null new-session "$scriptDir/launch.sh"
fi
