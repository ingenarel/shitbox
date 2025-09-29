#!/usr/bin/env bash

swaymsg 'bindsym Escape exec "pkill sov"'

pgrep sov || {
    mkfifo /tmp/sovpipe
    tail -f /tmp/sovpipe | sov -t 500 &
}

echo 1 > /tmp/sovpipe
