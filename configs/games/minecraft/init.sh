#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$(realpath --canonicalize-missing "$scriptDir/../../../utils/safelink.sh")"

installDeps(){ # {{{
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
} # }}}

installPrism(){ # {{{
    ls "$HOME/Downloads/prismlauncher-cracked/PrismLauncher"*\
        ||
    {
        wget\
            --no-use-server-timestamps\
            --directory-prefix="$HOME/Downloads/prismlauncher-cracked/"\
            "$(
                curl https://api.github.com/repos/Diegiwg/PrismLauncher-Cracked/releases/latest\
                |
                grep -oE "https://github.com/Diegiwg/PrismLauncher-Cracked/releases/download/[0-9.]+/PrismLauncher-Linux-Qt6-Portable-[0-9.]+\.tar\.gz"
        )"

        sleep 1; sync; sleep 1

        fileName=$(ls -t "$HOME/Downloads/prismlauncher-cracked" | tail -n1)
        tar -xvf "$HOME/Downloads/prismlauncher-cracked/$fileName" -C "$HOME/Downloads/prismlauncher-cracked"
    }
} # }}}

setupPrism(){ # {{{
    [[ -d "$HOME/Downloads/prismlauncher-cracked" ]] || mkdir --parents "$HOME/Downloads/prismlauncher-cracked"

    [[ -d "$HOME/.local/share/applications" ]] || mkdir --parents "$HOME/.local/share/applications"

    safelink "$scriptDir/org.prismlauncher.PrismLauncher.desktop" "$HOME/.local/share/applications/org.prismlauncher.PrismLauncher.desktop"

    [[ -d "$HOME/Downloads/prismlauncher-cracked/myPlugins" ]] || mkdir --parents "$HOME/Downloads/prismlauncher-cracked/myPlugins"
} # }}}

installModrinthMod(){ # {{{

    local downloadData="$(curl -G "https://api.modrinth.com/v2/project/$1/version")"

    local downloadURL="$(
        echo "$downloadData"\
            |
        grep -oE "https://cdn.modrinth.com/data/[a-zA-Z0-9]+/versions/[^\"]*$3[^\"]*"\
            |
        head -n1
    )"

    # echo "downloadURL = $downloadURL"

    local filename="$(echo "$downloadData" | grep -oE "\"filename\":\"[^\"]*$3[^\"]*" | head -n1 | grep -oE "[^\"]+$")"
    # echo "filename = $filename"

    ls "$2/$filename"\
        ||
    {
        wget --directory-prefix="$2" "$downloadURL"

        deps="$(
            curl -G https://api.modrinth.com/v2/project/$1/dependencies\
                |
            sed -nE 's/.*"slug":"([^"]+)".*/\1/p'
        )"

        [[ -n "$deps" ]] && {
            for dep in $deps; do
                installModrinthMod "$dep" "$2" "$3"
            done
        }
    }

} # }}}

installGithubMod(){ # {{{

    local downloadURL="$(
        curl -G "https://api.github.com/repos/$1/releases/latest"\
            |
        grep -oE "https://github\.com/$1/releases/download/[^\"]*$3[^\"]*"
    )"

    echo "downloadURL = $downloadURL"

    local filename="$(echo "$downloadURL" | grep -oE "[^/]+$")"
    echo "filename = $filename"

    ls "$2/$filename"\
        ||
    {
        wget --directory-prefix="$2" "$downloadURL"
    }

} # }}}

installDeps
installPrism
setupPrism

installModrinthMod minihud          "$HOME/Downloads/prismlauncher-cracked/myPlugins" fabric
installModrinthMod continuity       "$HOME/Downloads/prismlauncher-cracked/myPlugins"
installModrinthMod dynamic-fps      "$HOME/Downloads/prismlauncher-cracked/myPlugins" fabric
installModrinthMod fabric-api       "$HOME/Downloads/prismlauncher-cracked/myPlugins" fabric
installModrinthMod ferrite-core     "$HOME/Downloads/prismlauncher-cracked/myPlugins" fabric
installModrinthMod litematica       "$HOME/Downloads/prismlauncher-cracked/myPlugins" fabric
installModrinthMod lithium          "$HOME/Downloads/prismlauncher-cracked/myPlugins" fabric
installModrinthMod modmenu          "$HOME/Downloads/prismlauncher-cracked/myPlugins"
installModrinthMod placeholder-api  "$HOME/Downloads/prismlauncher-cracked/myPlugins"
installModrinthMod sodium-extra     "$HOME/Downloads/prismlauncher-cracked/myPlugins" fabric
installModrinthMod tweakeroo        "$HOME/Downloads/prismlauncher-cracked/myPlugins" fabric

installGithubMod "cabaletta/baritone" "$HOME/Downloads/prismlauncher-cracked/myPlugins" "standalone-fabric"
