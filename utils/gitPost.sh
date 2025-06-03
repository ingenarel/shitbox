#!/usr/bin/env bash

if git -C "$1" config --local --list | grep -qEi "https://github.com/ingenarel"; then
    x="$(git -C "$1" config --local --get-all remote.origin.url | head -n1)"
    git -C "$1" config --local --unset-all remote.origin.url
    git -C "$1" config --local --add remote.origin.url "$(
        echo "$x" | sed -E "s/https\:\/\/github.com\/(.+)/git@github.com\:\1/"
    )"
    git -C "$1" config --local --add remote.origin.url "$(
        echo "$x" | sed -E "s/https\:\/\/github.com\/(.+)/git@gitlab.com\:\1/"
    )"
fi
git -C "$1" switch master
