#!/usr/bin/env bash

[ -z "$HOST" ] && {
    export HOST="$(hostname)"
}

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$scriptDir/packages.sh"

[ "$HOST" = "gentoo-main" ] && {
    source "$nonvmshit"
}
source "$scriptDir/../utils/safelink.sh"

# ram="$((
#         $(
#             grep --extended-regexp 'MemTotal' /proc/meminfo | sed --expression='s/[^0-9]//g'
#         ) / (1000 * 1000)
# ))"

packagesToInstall="\
    app-portage/genlop\
    app-portage/smart-live-rebuild\
    app-portage/eix\
    dev-util/pkgdev\
    app-portage/pycargoebuild\
    app-portage/pram\
"

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
            sudo emerge --noreplace --ask n app-crypt/libmd
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
        "sway")
            package="gui-wm/sway"
            ;;
        "xwayland")
            package="x11-base/xwayland"
            ;;
        "autotiling")
            package="x11-misc/autotiling"
            ;;
        "xdg-desktop-portal-wlr")
            package="gui-libs/xdg-desktop-portal-wlr"
            ;;
        "sov")
            # need to package
            package=""
            ;;
        "waybar")
            package="gui-apps/waybar"
            ;;
        "fuzzel")
            package="gui-apps/fuzzel"
            ;;
        "libnotify")
            package="x11-libs/libnotify"
            ;;
        "swaync")
            package="gui-apps/swaync"
            ;;
        "sweet-gtk")
            # need to pacakge
            package=""
            ;;
        "swww")
            package="gui-apps/swww"
            ;;
        "wl-clipboard")
            package="gui-apps/wl-clipboard"
            ;;
        "ydotool")
            package="x11-misc/ydotool"
            ;;
        "hyprpicker")
            package="gui-apps/hyprpicker"
            ;;
        "pipewire-pulse")
            package="media-video/pipewire"
            ;;
        "keyd")
            package="app-misc/keyd"
            ;;
        "grim")
            package="gui-apps/grim"
            ;;
        "slurp")
            package="gui-apps/slurp"
            ;;
        "satty")
            package="gui-apps/satty"
            ;;
        "kitty")
            package="x11-terms/kitty"
            ;;
        "audacity")
            package="media-sound/audacity app-doc/audacity"
            ;;
        "noise-suppression-for-voice")
            package="media-libs/noise-suppression-for-voice"
            ;;
        "blender")
            package="media-gfx/blender-bin"
            ;;
        "kdenlive")
            package="kde-apps/kdenlive"
            ;;
        "obs-studio")
            package="media-video/obs-studio"
            ;;
        "gimp")
            package="media-gfx/gimp"
            ;;
        "vesktop")
            package="net-im/vesktop-bin"
            ;;
        "element")
            package="net-im/element-desktop-bin"
            ;;
        "qemu")
            package="app-emulation/qemu"
            ;;
        "zen")
            package="www-client/zen-bin"
            ;;
        "mozlz4")
            # need to package
            package=""
            ;;
        "keepassxc")
            package="app-admin/keepassxc"
            ;;
        "gnome-keyring")
            package="gnome-base/gnome-keyring"
            ;;
            # gonna try to move to pipewire
            # "pavucontrol")
            #     package=""
            #     ;;
        "pwvucontrol")
            # need to be packaged
            package=""
            ;;
        "qbittorrent")
            package="net-p2p/qbittorrent"
            ;;
        "vimiv-qt")
            package="media-gfx/vimiv-qt"
            ;;
        "vlc")
            package="media-video/vlc"
            ;;
        "zathura")
            package="app-text/zathura app-text/zathura-pdf-mupdf"
            ;;
        "hack-nerd")
            package="media-fonts/nerdfonts"
            ;;
        "noto-fonts")
            package="media-fonts/noto media-fonts/noto-cjk media-fonts/noto-emoji"
            ;;
        "mpd")
            package="media-sound/mpd"
            ;;
        "mediainfo")
            package="media-video/mediainfo"
            ;;
        "mpc")
            package="media-sound/mpc"
            ;;
        "rmpc")
            package="media-sound/rmpc"
            ;;
        "nicotine")
            package="net-p2p/nicotine+"
            ;;
        "cava")
            package="media-sound/cava"
            ;;
        "ncmpcpp")
            package="media-sound/ncmpcpp"
            ;;
        "mpd-discord-rpc")
            # need to package myself
            package=""
            ;;
        "tailscale")
            package="net-vpn/tailscale"
            ;;
        "ntfs-3g")
            package="sys-fs/ntfs3g"
            ;;
        "ffmpeg")
            package="media-video/ffmpeg"
            ;;
        "yt-dlp")
            package="net-misc/yt-dlp"
            ;;
        "python-mutagen")
            package="media-libs/mutagen"
            ;;
        "wine")
            package="app-emulation/wine-proton virtual/wine"
            ;;
        "lutris")
            package="games-util/lutris"
            ;;
        "protonup-rs")
            # need to package myself
            package=""
            ;;
        "neomutt")
            package="mail-client/neomutt"
            ;;
        "mutt-wizard")
            package="mail-client/mutt-wizard"
            ;;
        "elinks")
            package="www-client/elinks"
            ;;
        "imagemagick")
            package="media-gfx/imagemagick"
            ;;
        "sshfs")
            package="net-fs/sshfs"
            ;;
        "mpv")
            package="media-video/mpv"
            ;;
        "gitleaks")
            # need to package it myself
            package=""
            ;;
        "librewolf")
            sudo eselect repository add librewolf git https://codeberg.org/librewolf/gentoo.git
            package="www-client/librewolf-bin"
            ;;
    esac
    packagesToInstall="$packagesToInstall $package"
done

[[ -n $packagesToInstall ]] && eval "sudo emerge --noreplace --keep-going $packagesToInstall"
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

{
    command -v rustup-init-gentoo && ! command -v rustup
    } && {
    rustup-init-gentoo --symlink
}

# echo "${packagesToInstall[@]}"
