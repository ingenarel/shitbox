#!/usr/bin/env bash

windowSize="$(kitten icat --print-window-size)"
xPixel=$(echo "$windowSize" | awk -F 'x' '{ print $1 / 2 }')
yPixel=$(echo "$windowSize" | awk -F 'x' '{ print $2 }')

cacheDir="$HOME/.cache/zathuraLauncher"
[[ ! -d "$cacheDir" ]] && mkdir --parents "$cacheDir"
cacheFile="$cacheDir/$(
    echo "$1" | gpg --print-md SHA512 | tr -d '[:space:]'
)"

[[ ! -f "$cacheFile" ]] && {
    pdftoppm\
        -png\
        -singlefile\
        -scale-to-x "$xPixel"\
        -scale-to-y "$yPixel"\
        "$1"\
        "$cacheFile" > /dev/null 2>&1
}

kitten icat\
    --stdin no\
    --align left\
    --use-window-size "$(( COLUMNS / 2 )),$(( LINES - 3 )),$xPixel,$yPixel"\
    --transfer-mode=file \
    "${cacheFile}.png"
