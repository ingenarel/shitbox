#!/bin/sh

export NVIM_SERVER_PORT=8629

ss --listening sport eq "$NVIM_SERVER_PORT" 2>/dev/null | grep -qe "$NVIM_SERVER_PORT" &&
command nvim --server "127.0.0.1:$NVIM_SERVER_PORT" --remote-ui "$@" ||
command nvim --listen "127.0.0.1:$NVIM_SERVER_PORT" "$@"
