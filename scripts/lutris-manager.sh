command -v lutris >/dev/null 2>&1 || {
    echo "lutris not found"
    exit
}

export PROTONPATH="$HOME/.local/share/lutris/runners/proton/ge-proton"

gameName="$(lutris --installed --list-games 2>/dev/null | awk -F '|' '{print $3}' | sed -E 's/^\s+//; s/\s+$//' | fuzzel --dmenu)"
[[ -n "$gameName" ]] && {
    lutris "$gameName" --output-script "/tmp/$gameName.sh"
    "/tmp/$gameName.sh"
}
