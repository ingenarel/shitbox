#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$(realpath --canonicalize-missing "$scriptDir/../../../utils/safelink.sh")"

depends=(
    cmark
    gcc-libs
    glibc
    hicolor-icon-theme
    java-runtime=17
    libgl
    qt6-5compat
    qt6-base
    qt6-imageformats
    qt6-networkauth
    qt6-svg
    quazip-qt6
    tomlplusplus
    zlib
)

grep -qEi "arch" /etc/os-release && eval "paru -S --needed ${depends[@]}"

[[ -d "$HOME/Downloads/prismlauncher-cracked" ]] || mkdir --parents "$HOME/Downloads/prismlauncher-cracked"

ls "$HOME/Downloads/prismlauncher-cracked/PrismLauncher-Linux-Qt6-Portable-"*\
    || {
    wget\
        --no-use-server-timestamps\
        --directory-prefix="$HOME/Downloads/prismlauncher-cracked/"\
        "$(
    curl https://api.github.com/repos/Diegiwg/PrismLauncher-Cracked/releases/latest\
        |
    grep -oE "https://github.com/Diegiwg/PrismLauncher-Cracked/releases/download/[0-9.]+/PrismLauncher-Linux-Qt6-Portable-[0-9.]+\.tar\.gz"
    )"

    sleep 1
    sync
    sleep 1

    fileName=$(ls -t "$HOME/Downloads/prismlauncher-cracked" | tail -n1)
    tar -xvf "$HOME/Downloads/prismlauncher-cracked/$fileName" -C "$HOME/Downloads/prismlauncher-cracked"
}

[[ -d "$HOME/.local/share/applications" ]] || mkdir --parents "$HOME/.local/share/applications"

safelink "$scriptDir/org.prismlauncher.PrismLauncher.desktop" "$HOME/.local/share/applications/org.prismlauncher.PrismLauncher.desktop"

[[ -d "$HOME/Downloads/prismlauncher-cracked/myPlugins" ]] || mkdir --parents "$HOME/Downloads/prismlauncher-cracked/myPlugins"

ls "$HOME/Downloads/prismlauncher-cracked/myPlugins/minihud-fabric-"*\
    ||
wget\
    --no-use-server-timestamps\
    --directory-prefix="$HOME/Downloads/prismlauncher-cracked/myPlugins"\
    "$(
        curl https://api.github.com/repos/sakura-ryoko/minihud/releases/latest\
                |
        grep -oE "https://github.com/sakura-ryoko/minihud/releases/download/\S+\.jar"
)"
