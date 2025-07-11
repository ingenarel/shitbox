#!/usr/bin/env bash
scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$scriptDir/packages.sh"
source "$scriptDir/../utils/safelink.sh"

# ram="$((
#         $(
#             grep --extended-regexp 'MemTotal' /proc/meminfo | sed --expression='s/[^0-9]//g'
#         ) / (1000 * 1000)
# ))"

packagesToInstall=""

extracommands=""

systemServices=()
userServices=()
groups=(wheel)

for package in "${packages[@]}"; do
    case "$package" in
        git)
            package="dev-vcs/git"
            ;;
        greetd)
            package="gui-libs/greetd"
            systemServices+=(greetd)
            ;;
        glab)
            package="dev-util/gitlab-cli"
            ;;
        btop)
            package="btop app-crypt/libmd"
    esac
    packagesToInstall="$packagesToInstall $package"
done

[[ -n $packagesToInstall ]] && eval "sudo emerge --noreplace $packagesToInstall"
[[ -n $extracommands ]] && eval "$extracommands"

myshell="$(which zsh)"
command -v "$myshell" && {
    [[ "$myshell" == "$SHELL" ]] || chsh -s "$myshell"
}

[[ "${#systemServices[@]}" -gt 0 ]] && {
    for service in "${systemServices[@]}"; do
        [[ "$(systemctl is-enabled "$service" )" == "enabled" ]] || {
            systemctl enable "$service" && systemctl start "$service"
        }
    done
}

[[ "${#userServices[@]}" -gt 0 ]] && {
    for service in "${userServices[@]}"; do
        [[ "$(systemctl --user is-enabled "$service" )" == "enabled" ]] || {
            systemctl --user enable "$service" && systemctl --user start "$service"
        }
    done
}

[[ "${#groups[@]}" -gt 0 ]] && {
    for group in "${groups[@]}"; do
        groups | grep -qEi "$group" || {
            sudo usermod -aG "$group" "$USER"
        }
    done
}

# echo "${packagesToInstall[@]}"
