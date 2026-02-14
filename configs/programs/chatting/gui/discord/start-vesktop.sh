#!/usr/bin/sh

command -v vesktop && VESKTOP_COMMAND=vesktop || command -v vesktop-bin && VESKTOP_COMMAND=vesktop-bin || exit 1

systemctl --quiet is-active mpd-discord-rpc && RPC_ACTIVE=true

if [ "$RPC_ACTIVE" = true ]; then
    exec $VESKTOP_COMMAND "$@"
else
    systemctl --quiet --user start mpd-discord-rpc
    $VESKTOP_COMMAND "$@"
    systemctl --user stop mpd-discord-rpc
fi

