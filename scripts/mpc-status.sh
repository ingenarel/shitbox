#!/usr/bin/env sh

output="$(mpc status)"

notify-send\
    "$(echo "$output" | head -n1 )"\
    "$(echo "$output"| tail -n +2)"
