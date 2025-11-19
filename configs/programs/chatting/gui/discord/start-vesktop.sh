#!/usr/bin/sh

systemctl --quiet is-active mpd-discord-rpc && RPC_ACTIVE=true

if [ "$RPC_ACTIVE" = true ]; then
    exec vesktop "$@"
else
    systemctl --quiet --user start mpd-discord-rpc
    vesktop "$@"
    systemctl --user stop mpd-discord-rpc
fi

