#!/usr/bin/env bash
if [[ $(tmux list-sessions) ]]; then
    tmux attach
else
    # tmux new-session "fastfetch --logo-padding-left \$(( ( \$(tput cols) - 93) / 2 )); \$SHELL"
    tmux new-session "task; $SHELL"
fi
