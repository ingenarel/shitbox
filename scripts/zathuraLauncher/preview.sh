#!/usr/bin/env bash

windowSize="$(kitten icat --print-window-size)"
xPixel=$(echo "$windowSize" | awk -F 'x' '{ print $1 / 2 }')
yPixel=$(echo "$windowSize" | awk -F 'x' '{ print $2 }')
xChars=$(( COLUMNS / 2 ))
yChars=$(( LINES - 3 ))

cacheDir="$HOME/.cache/zathuraLauncher"
[[ ! -d "$cacheDir" ]] && mkdir --parents "$cacheDir"
cacheFile="$cacheDir/$(
    echo "${1}${xChars}${yChars}" | gpg --print-md SHA512 | tr -d '[:space:]'
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
    --use-window-size "$xChars,$yChars,$xPixel,$yPixel"\
    --transfer-mode=file \
    "${cacheFile}.png"
