#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

[[ -z $FZF_DEFAULT_OPTS ]] && export FZF_DEFAULT_OPTS="--bind=alt-n:down,alt-p:up"

[[ -z "$BOOK_PATH" ]] && BOOK_PATH="$HOME/Documents"

command -v rg >/dev/null 2>&1 || {
    echo "rg not found"
    exit 1
}

command -v fzf >/dev/null 2>&1 || {
    echo "fzf not found"
    exit 1
}

[[ -n $SWAYSOCK ]] && execCommand="swaymsg exec"
#TODO: add one for hyprland

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

# echo "$choice"

if [[ -n "$choice" ]]; then
    $execCommand zathura \""$choice\""
else
    exit
fi
