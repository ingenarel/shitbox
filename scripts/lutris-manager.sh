gameName="$(lutris --installed --list-games 2>/dev/null | awk -F '|' '{print $3}' | sed -E 's/^\s+//; s/\s+$//' | fuzzel --dmenu)"
lutris "$gameName" --output-script "/tmp/$gameName.sh"
"/tmp/$gameName.sh"
