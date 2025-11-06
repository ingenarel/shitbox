#!/usr/bin/env bash
if tmux list-sessions | grep -q work; then
    tmux attach -t work
else
    tmux new-session -s 'work' "task; $SHELL"
fi
