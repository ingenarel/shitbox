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
    case "$package" in
        git)
            package="dev-vcs/git"
            ;;
        greetd)
            package="gui-libs/greetd"
            paru -Q "$package" || extracommands="$extracommands sudo systemctl enable greetd; "
            ;;
        tuigreet)
            paru -Q "$package" || (
                (command -v Hyprland &&
                    safelink "$scriptDir/../configs/programs/greetd/config-hyprland.toml" "/etc/greetd/config.toml" 1
                ) || safelink "$scriptDir/../configs/programs/greetd/config-tmux.toml" "/etc/greetd/config.toml" 1
            )
            ;;
    esac
    packagesToInstall="$packagesToInstall $package"
done

[[ -n $packagesToInstall ]] && eval "emerge --noreplace $packagesToInstall"
[[ -n $extracommands ]] && eval "$extracommands"

myshell="$(which zsh)"
command -v "$myshell" && ( [[ "$myshell" == "$SHELL" ]] || chsh -s "$myshell")

# echo "${packagesToInstall[@]}"
