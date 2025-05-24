#!/usr/bin/env bash
scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$scriptDir/packages.sh"
source "$scriptDir/../utils/safelink.sh"

ram="$((
        $(
            grep --extended-regexp 'MemTotal' /proc/meminfo | sed --expression='s/[^0-9]//g'
        ) / (1000 * 1000)
))"

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
                extracommands="$extracommands sudo systemctl enable greetd; "
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

[[ -n $packagesToInstall ]] && eval "paru --skipreview --noconfirm --mflags --quiet -S $packagesToInstall"
[[ -n $extracommands ]] && eval "$extracommands"

myshell="zsh"
command -v "$myshell" && chsh -s "$(which $myshell)"

# echo "${packagesToInstall[@]}"
