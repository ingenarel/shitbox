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

systemServices=()
userServices=()
groups=(wheel)

for package in "${packages[@]}"; do
    case "$package" in
        "neovim")
            package="neovim-git"
            ;;
        "yazi")
            [[ $ram -lt 8 ]] && package="yazi-nightly-bin" || package="yazi-git"
            ;;
        "lazygit")
            package="lazygit-git"
            ;;
        "greetd")
            systemServices+=(greetd)
            ;;
        "tuigreet")
            package="greetd-tuigreet-bin"
            (command -v Hyprland &&
                safelink "$scriptDir/../configs/programs/greetd/config-hyprland.toml" "/etc/greetd/config.toml" 1
            ) || safelink "$scriptDir/../configs/programs/greetd/config-tmux.toml" "/etc/greetd/config.toml" 1
            ;;
        "sweet-gtk")
            parentPath="$HOME/.themes"
            themePath="$parentPath/Sweet-Dark"
            [[ -d "$parentPath" ]] || mkdir --parents "$parentPath"
            [[ -d "$themePath" ]] || (
                wget --directory-prefix="$parentPath" "https://github.com/EliverLara/Sweet/releases/download/v6.0/Sweet-Dark.tar.xz" &&
                tar -xvf "$parentPath/Sweet-Dark.tar.xz" -C "$parentPath" &&
                rm "$parentPath/Sweet-Dark.tar.xz"
            )
            continue
            ;;
        "hyprland")
            # figure out a way to autoinstall plugins if not installed
            ;;
        "vesktop")
            package="vesktop-git"
            ;;
        "cinny")
            package="cinny-desktop-bin"
            ;;
        "qemu")
            package="qemu-desktop"
            ;;
        "zen")
            package="zen-twilight-bin"
            ;;
        "hack-nerd")
            package="ttf-hack-nerd"
            ;;
        "noto-fonts")
            package="noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra"
            ;;
        "keyd")
            systemServices+=(keyd)
            ;;
        "vimiv-qt")
            continue
            ;;
        "nicotine")
            package="nicotine+"
            ;;
        "mozlz4")
            package="mozlz4-bin"
            ;;
        "mpd")
            userServices+=(mpd)
            ;;
        "ydotool")
            userServices+=(ydotool)
            groups+=(input)
            ;;
    esac
    paru -Q "$package" || packagesToInstall="$packagesToInstall $package"
done

[[ -n $packagesToInstall ]] && eval "paru -S --needed $packagesToInstall"
[[ -n $extracommands ]] && eval "$extracommands"

myshell="$(which zsh)"
command -v "$myshell" && ( [[ "$myshell" == "$SHELL" ]] || chsh -s "$myshell")

[[ "${#systemServices[@]}" -gt 0 ]] && (for service in "${systemServices[@]}"; do 
    [[ "$(systemctl is-enabled $service)" == "enabled" ]] || (systemctl enable "$service" && systemctl start "$service")
done)

[[ "${#userServices[@]}" -gt 0 ]] && (for service in "${userServices[@]}"; do 
    [[ "$(systemctl --user is-enabled $service)" == "enabled" ]] || (systemctl --user enable "$service" && systemctl --user start "$service")
done)

[[ "${#groups[@]}" -gt 0 ]] && (for group in "${groups[@]}"; do
    echo "$(groups)" | grep -qEi "$group" || (sudo usermod -aG "$group" $USER)
done)

# echo "${packagesToInstall[@]}"
