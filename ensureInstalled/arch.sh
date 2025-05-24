#!/usr/bin/env bash
scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$scriptDir/packages.sh"

ram="$((
        $(
            grep --extended-regexp 'MemTotal' /proc/meminfo | sed --expression='s/[^0-9]//g'
        ) / (1000 * 1000)
))"

safelink(){
    parentPath="$(realpath --canonicalize-missing "$2/..")"
    [[ -d "$parentPath" ]] || ([[ "$3" != 1 ]] && mkdir --parents "$parentPath" || sudo mkdir --parents "$parentPath")
    [[ -d "$2" ]] || ([[ "$3" != 1 ]] && ln -sf "$1" "$2" || sudo ln -sf "$1" "$2" && echo "linked $1 to $2")
}

packagesToInstall=""

extracommands=""

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
            greetd)
                packagesToInstall="$packagesToInstall $package"
                extracommands="$extracommands systemctl enable greetd; "
                ;;
            tuigreet)
                packagesToInstall="$packagesToInstall greetd-tuigreet-bin"
                if command -v Hyprland; then
                    safelink "$scriptDir/../configs/programs/greetd/config-hyprland.toml" "/etc/greetd/config.toml" 1
                else
                    safelink "$scriptDir/../configs/programs/greetd/config-tmux.toml" "/etc/greetd/config.toml" 1
                fi
                ;;
            *)
                packagesToInstall="$packagesToInstall $package"
                ;;
        esac
    fi
done

[[ -n $packagesToInstall ]] && eval "paru -S $packagesToInstall"
[[ -n $extracommands ]] && eval "$extracommands"

myshell="zsh"
command -v "$myshell" && chsh -s "$(which $myshell)"

# echo "${packagesToInstall[@]}"
