#!/usr/bin/env sh

renamePanes(){
    _windowInfo="$(tmux display-message -p '#{session_name}:#{window_index}:#{pane_current_command}')"
    _cmd="$( echo "$_windowInfo" | awk -F ':' '{print $3}')"
    case "$_cmd" in
        nvim)
            name=""
            ;;
        bash|zsh|sh|fish)
            name=""
            ;;
        ssh)
            name="🖧"
            ;;
        man)
            name="📖"
            ;;
        btop|htop|top)
            name=""
            ;;
        yazi)
            name="🗃️"
            ;;
        sudo|doas)
            name="🛡️"
            ;;
        git|lazygit)
            name=""
            ;;
        ncmpcpp|rmpc)
            name="🎵"
            ;;
        weechat)
            name="󰰭"
            ;;
        iamb)
            name="󰯊"
            ;;
        discordo)
            name=""
            ;;
        *)
            name="$_cmd"
            ;;
    esac
    tmux rename-window -t "$(echo "$_windowInfo" | awk -F ':' '{print $1 ":" $2 }')" "$name"
}

listOfProcesses="$(pgrep -f tmux-pane-renamer.sh)"
#shellcheck disable=SC2015
[ "$( echo "$listOfProcesses" | wc -l )" -gt "1" ] && kill "$(echo "$listOfProcesses" | head -n -1)"
while sleep 1; do
    tmux list-sessions > /dev/null || exit
    renamePanes
done
