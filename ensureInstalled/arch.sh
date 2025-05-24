#!/usr/bin/env bash
scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$scriptDir/packages.sh"

ram="$((
        $(
            grep --extended-regexp 'MemTotal' /proc/meminfo | sed --expression='s/[^0-9]//g'
        ) / (1000 * 1000)
))"

safelink(){
    [[ -d "$(realpath --canonicalize-missing "$2/..")" ]] || ([[ "$3" != 1 ]] && mkdir --parents "$2" || sudo mkdir --parents "$2")
    [[ -d "$2" ]] || ([[ "$3" != 1 ]] && ln -sf "$1" "$2" || sudo ln -sf "$1" "$2" && echo "linked $1 to $2")
}

packagesToInstall=""

for package in "${packages[@]}"; do
    if ! paru -Q "$package"; then
        case "$package" in
            neovim)
                packagesToInstall="$packagesToInstall neovim-git"
                ;;
            yazi)
                [[ $ram -lt 8 ]] && packagesToInstall="$packagesToInstall yazi-nightly-bin" || packagesToInstall="$packagesToInstall yazi-git"
                ;;
            lazygit)
                packagesToInstall="$packagesToInstall lazygit-git"
                ;;
            *)
                packagesToInstall="$packagesToInstall $package"
                ;;
        esac
    fi
done

[[ -n $packagesToInstall ]] && eval "paru -S $packagesToInstall"

# echo "${packagesToInstall[@]}"
