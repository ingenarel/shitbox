#!/usr/bin/sh

scriptDir=$(realpath "$0" | xargs --null dirname)

kitten @ action\
    new_tab "$scriptDir/tmux-chat.sh"

kitten @ action\
    new_tab "$scriptDir/tmux-work.sh"
