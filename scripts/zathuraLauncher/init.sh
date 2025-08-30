scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

if [[ -n $TERM ]]; then
    "$scriptDir/launch.sh"
else
    kitty "$scriptDir/launch.sh"
fi
