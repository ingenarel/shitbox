#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

[[ -z "$BOOK_PATH" ]] && BOOK_PATH="$HOME/Documents"

command -v rg >/dev/null 2>&1 || {
    echo "rg not found"
    exit 1
}

command -v fzf >/dev/null 2>&1 || {
    echo "fzf not found"
    exit 1
}

choice="$(
    rg --type-add 'epub:*.epub'\
        --files\
        --follow\
        --type pdf\
        --type epub\
        "$BOOK_PATH"\
        |
    fzf\
        --wrap\
        --preview "$scriptDir/preview.sh {}"
)"

echo "$choice"

if [[ -n "$choice" ]]; then
    zathura "$choice" &
else
    exit
fi
