#!/usr/bin/sh

scriptDir=$(realpath "$0" | xargs --null dirname)

"$scriptDir/tmux-chat.sh" &\
    "$scriptDir/tmux-work.sh"
