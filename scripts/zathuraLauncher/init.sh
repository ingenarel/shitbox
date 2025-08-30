scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

if pgrep tmux; then
    tmux new-window "$scriptDir/launch.sh"
elif [[ "$TERM" != "linux" ]]; then
    "$scriptDir/launch.sh"
else
    export TERM=xterm-kitty
    kitty "$scriptDir/launch.sh"
fi
