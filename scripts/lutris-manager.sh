command -v lutris >/dev/null 2>&1 || {
    echo "lutris not found"
    exit
}

command -v fuzzel >/dev/null 2>&1 || {
    echo "fuzzel not found"
    exit
}

export PROTONPATH="$HOME/.local/share/lutris/runners/proton/ge-proton"
gameNamesFile="$HOME/.cache/lutris-manager-names"

setGameNames(){
    [[ -z $GAME_NAMES ]] && GAME_NAMES="$(
        lutris\
            --installed\
            --list-games\
            2>/dev/null\
            |
        awk\
            -F '|'\
            '{print $3}'\
            |
        sed\
            -E 's/^\s+//; s/\s+$//'
    )"
}

getCacheNames(){
    [[ -z $CACHE_NAMES ]] && CACHE_NAMES="$(
        [[ -f "$gameNamesFile" ]] && {
            cat "$gameNamesFile"
            } || {
            setGameNames
            echo "$GAME_NAMES" > "$gameNamesFile"
            cat "$gameNamesFile"
        }
    )"
}

getCacheNames

gameName="$(
    echo "$CACHE_NAMES"\
        |
    fuzzel\
        --dmenu\
        --cache="$HOME/.cache/lutris-manager-fuzzel"
)"

[[ -n "$gameName" ]] && {
    lutris "$gameName" --output-script "/tmp/$gameName.sh"
    "/tmp/$gameName.sh"
}

setGameNames
[[ "$CACHE_NAMES" != "$GAME_NAMES" ]] && echo "$GAME_NAMES" > "$gameNamesFile"
