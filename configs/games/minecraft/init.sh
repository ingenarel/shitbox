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

installDeps
installPrism
setupPrism

# mods to automate installation somehow
# Continuity (https://modrinth.com/mod/1IjD5062)
# Dynamic FPS (https://modrinth.com/mod/LQ3K71Q1)
# Fabric API (https://modrinth.com/mod/P7dR8mSH)
# FerriteCore (https://modrinth.com/mod/uXXizFIs)
# Litematica (https://modrinth.com/mod/bEpr0Arc)
# Lithium (https://modrinth.com/mod/gvQqBUqZ)
# MaLiLib (https://modrinth.com/mod/GcWjdA9I)
# MiniHUD (https://modrinth.com/mod/UMxybHE8)
# Mod Menu (https://modrinth.com/mod/mOgUt4GM)
# Placeholder API (https://modrinth.com/mod/eXts2L7r)
# Sodium (https://modrinth.com/mod/AANobbMI)
# Sodium Extra (https://modrinth.com/mod/PtjYWJkn)
# Tweakeroo (https://modrinth.com/mod/t5wuYk45)
