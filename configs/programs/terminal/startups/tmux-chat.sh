#!/usr/bin/sh
if tmux list-sessions | grep -q chat; then
    tmux attach -t chat
else
    tmux new-session -s 'chat' "neomutt"\
        \;\
        new-window "iamb"\
        \;\
        new-window "weechat"
fi
