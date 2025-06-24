scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

[[ -n "$WAYLAND_DISPLAY" ]] && {
    [[ -d "$HOME/.local/share/lutris/runners/proton/ge-proton" ]] || protonup-rs
    "$scriptDir/skyrim/init.sh"
    "$scriptDir/minecraft/init.sh"
}
