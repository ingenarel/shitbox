#!/usr/bin/sh
if tmux list-sessions | grep -q chat; then
    tmux attach -t chat
else
    tmux new-session -s 'chat' "neomutt; $SHELL"\
        \;\
        new-window "iamb; $SHELL"\
        \;\
        new-window "weechat; $SHELL"
fi
