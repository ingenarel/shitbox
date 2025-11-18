#!/usr/bin/sh
if tmux list-sessions | grep -q chat; then
    exec tmux attach -t chat
else
    exec tmux new-session -s 'chat' "$SHELL" -c "neomutt"\
        \;\
        new-window "$SHELL" -c "weechat"\
        # \;\
        # new-window "$SHELL" -c "iamb"\
        # \;\
        # new-window "$SHELL" -c "discordo"
fi
