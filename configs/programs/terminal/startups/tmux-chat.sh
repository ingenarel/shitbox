#!/usr/bin/sh
if tmux list-sessions | grep -q chat; then
    exec tmux attach -t chat
else
    exec tmux new-session -d -s 'chat' torsocks aerc\;\
        rename-window -t chat:0 '📧'\;\
        new-window weechat\;\
        rename-window -t chat:1 '󰰭'\;\
        new-window torsocks oxicord --enable-desktop-notifications true --group-guilds true\;\
        rename-window -t chat:2 ''\;\
        new-window iamb\;\
        rename-window -t chat:3 '󰯊'
    # new-window env -i HOME="$HOME" PATH="$PATH" TERM=tmux-256color sh -i -l -c 'env; sleep 99999'\;
    # new-window env -i HOME="$HOME" sh -l -c 'iamb'\;\
        # new-window torsocks oxicord --enable-desktop-notifications true --group-guilds true
fi
