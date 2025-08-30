scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

#TODO: ACTUALLY FIX THIS BITCH
if [[ "$TERM" != "linux" ]]; then
    "$scriptDir/launch.sh"
else
    export TERM=xterm-kitty
    kitty "$scriptDir/launch.sh"
fi
