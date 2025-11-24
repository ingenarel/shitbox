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
groups=(wheel portage)

for package in "${packages[@]}"; do
    case "$package" in
        "git")
            package="dev-vcs/git"
            ;;
        "greetd")
            package="gui-libs/greetd"
            systemServices+=(greetd)
            ;;
        "glab")
            package="dev-util/gitlab-cli"
            ;;
        "btop")
            package="btop"
            sudo emerge app-crypt/libmd
            ;;
        "fastfetch")
            package="app-misc/fastfetch"
            ;;
        "fzf")
            package="app-shells/fzf"
            ;;
        "lazygit")
            package="dev-vcs/lazygit"
            ;;
        "neovim")
            package="app-editors/neovim"
            ;;
        "ripgrep")
            package="sys-apps/ripgrep"
            ;;
        "fd")
            package="sys-apps/fd"
            ;;
        "tmux")
            package="app-misc/tmux"
            ;;
        "zellij")
            package="app-misc/zellij"
            ;;
        "yazi")
            package="app-misc/yazi"
            ;;
        "superfile")
            package="app-misc/superfile"
            ;;
        "zsh")
            package="app-shells/zsh"
            ;;
        "tuigreet")
            package="gui-apps/tuigreet"
            ;;
        "zoxide")
            package="app-shells/zoxide"
            ;;
        "starship")
            package="app-shells/starship"
            ;;
        "github-cli")
            package="dev-util/github-cli"
            ;;
        "wget")
            package="net-misc/wget"
            ;;
        "7zip")
            package="app-arch/7zip"
            ;;
        "unzip")
            package="app-arch/unzip"
            ;;
        "zip")
            package="app-arch/zip"
            ;;
        "lsd")
            package="sys-apps/lsd"
            ;;
        "inotify-tools")
            package="sys-fs/inotify-tools"
            ;;
        "perl")
            package="dev-lang/perl"
            ;;
        "diskonaut")
            package="sys-fs/diskonaut"
            ;;
        "iamb")
            package="net-im/iamb"
            ;;
        "weechat")
            package="net-irc/weechat"
            ;;
        "hunspell")
            package="app-text/hunspell"
            ;;
        "tinyxxd")
            package="dev-util/tinyxxd"
            ;;
        "bat")
            package="sys-apps/bat"
            ;;
        "git-delta")
            package="dev-util/git-delta"
            ;;
        "tealdeer")
            package="app-misc/tealdeer"
            ;;
        "task")
            package="app-misc/task"
            ;;
        "torsocks")
            package="net-proxy/torsocks"
            ;;
        "sherlock")
            package="app-misc/sherlock"
            ;;
        "rclone")
            package="net-misc/rclone"
            ;;
        "rustup")
            package="dev-util/rustup"
            ;;
        "man-pages")
            package="sys-apps/man-pages"
            ;;
        "wgetpaste")
            package="app-text/wgetpaste"
            ;;
        "zpaq")
            package="app-arch/zpaq"
            ;;
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
            sudo systemctl enable "$service" && systemctl start "$service"
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
