#!/usr/bin/env bash
scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$scriptDir/../utils/safelink.sh"

setSudoConfigs(){
    automountLine="%wheel ALL=(ALL) NOPASSWD: /home/$USER/.config/shitbox/scripts/automount.sh"
    automountRegex="%wheel ALL=\(ALL\) NOPASSWD: /home/$USER/.config/shitbox/scripts/automount.sh"
    automountConfig="/etc/sudoers.d/automount"
    [[ -d "/etc/sudoers.d" ]] || sudo mkdir --parents "/etc/sudoers.d"
    sudo grep -qEi "$automountRegex" "$automountConfig" || echo "$automountLine" | sudo tee "$automountConfig"
}

setupConfigs(){
    [[ $HOME == "/root" ]] && HOME="/home/ingenarel"
    safelink "$scriptDir/programs/neovim/nvim"                                          "$HOME/.config/nvim"
    safelink "$scriptDir/programs/lazygit/config"                                       "$HOME/.config/lazygit"
    safelink "$scriptDir/programs/terminal/multiplexers/tmux/config"                    "$HOME/.config/tmux"
    safelink "$scriptDir/programs/terminal/multiplexers/tmux/tmux-powerline-config"     "$HOME/.config/tmux-powerline"
    safelink "$scriptDir/programs/zsh/config"                                           "$HOME/.config/zsh"
    safelink "$scriptDir/programs/starship.toml"                                        "$HOME/.config/starship.toml"
    safelink "$scriptDir/programs/git/config"                                           "$HOME/.gitconfig"
    safelink "$scriptDir/programs/music/cava/config"                                    "$HOME/.config/cava/config"
    safelink "$scriptDir/programs/music/ncmpcpp/config"                                 "$HOME/.config/ncmpcpp"
    safelink "$scriptDir/programs/music/rmpc/config.ron"                                "$HOME/.config/rmpc/config.ron"
    safelink "$scriptDir/programs/music/rmpc/themes/cyberpunk-neon.ron"                 "$HOME/.config/rmpc/themes/cyberpunk-neon.ron"
    safelink "$scriptDir/programs/neovim/lsp-configs/clangd"                            "$HOME/.config/clangd"
    safelink "$scriptDir/programs/terminal/emulators/foot/config"                       "$HOME/.config/foot"
    safelink "$scriptDir/programs/terminal/emulators/kitty/config"                      "$HOME/.config/kitty"
    safelink "$scriptDir/programs/terminal/emulators/wezterm"                           "$HOME/.config/wezterm"
    safelink "$scriptDir/programs/terminal/multiplexers/zellij/config"                  "$HOME/.config/zellij"
    safelink "$scriptDir/programs/music/mpd"                                            "$HOME/.config/mpd"
    safelink "$scriptDir/programs/fuzzel.ini"                                           "$HOME/.config/fuzzel/fuzzel.ini"

    echo "source $HOME/.config/zsh/init.zsh" >                                          "$HOME/.zshrc"

    safelink "$scriptDir/programs/yazi/config/alias"                                    "$HOME/.config/yazi/alias"
    safelink "$scriptDir/programs/yazi/config/init.lua"                                 "$HOME/.config/yazi/init.lua"
    safelink "$scriptDir/programs/yazi/config/keymap.toml"                              "$HOME/.config/yazi/keymap.toml"
    safelink "$scriptDir/programs/yazi/config/yazi.toml"                                "$HOME/.config/yazi/yazi.toml"
    safelink "$scriptDir/programs/yazi/config/package.toml"                             "$HOME/.config/yazi/package.toml"
    ls "$HOME/.config/yazi/plugins/"* > /dev/null || ya pkg install

    safelink "$scriptDir/programs/chatting/gui/discord/settings"                        "$HOME/.config/vesktop/settings"
    safelink "$scriptDir/programs/chatting/tui/iamb"                                    "$HOME/.config/iamb"
    safelink "$scriptDir/programs/chatting/tui/weechat"                                 "$HOME/.config/weechat"
    safelink "$scriptDir/programs/chatting/tui/discordo/config.toml"                    "$HOME/.config/discordo/config.toml"

    safelink  "$scriptDir/programs/browsers/firefox/policies.json"                      "/etc/zen/policies/policies.json" 1
    safelink  "$scriptDir/programs/browsers/firefox/profiles.ini"                       "$HOME/.zen/profiles.ini"
    mozlz4 -z "$scriptDir/programs/browsers/firefox/ingenarel/search.json"              "$HOME/.zen/ingenarel/search.json.mozlz4"
    cat\
        "$scriptDir/programs/browsers/firefox/arkenfox/user.js"\
        "$scriptDir/programs/browsers/firefox/zen.js"\
        > "$HOME/.zen/ingenarel/user.js"
    safelink "$scriptDir/programs/browsers/firefox/ingenarel/chrome/userChrome.css"     "$HOME/.zen/ingenarel/chrome/userChrome.css"

    safelink "$scriptDir/programs/WM/hyprland/config"                                   "$HOME/.config/hypr"
    safelink "$scriptDir/programs/WM/sway"                                              "$HOME/.config/sway"
    safelink "$scriptDir/programs/WM/river"                                             "$HOME/.config/river"

    safelink "$scriptDir/programs/keyd/default.conf"                                    "/etc/keyd/default.conf" 1

    grep -qEi "arch" /etc/os-release &&\
        safelink "$scriptDir/programs/pacman/pacman.conf"                               "/etc/pacman.conf" 1
    grep -qEi "gentoo" /etc/os-release && {
        safelink "$scriptDir/programs/portage/tui-vm-make.conf"                         "/etc/portage/make.conf" 1
        safelink "$scriptDir/programs/portage/package.use"                              "/etc/portage/package.use" 1
        safelink "$scriptDir/programs/portage/package.accept_keywords"                  "/etc/portage/package.accept_keywords" 1
        [[ -f "$HOME/.ssh/git" ]] && {
            [[ -d "$HOME/coding/git/gentoo" ]] || mkdir --parents "$HOME/coding/git/gentoo"
            [[ -d "$HOME/coding/git/gentoo/gentoo" ]] || {
                git clone -o upstream -b master --depth 1 https://github.com/gentoo/gentoo.git "$HOME/coding/git/gentoo/gentoo"
                git -C "$HOME/coding/git/gentoo/gentoo" remote add github git@github.com:ingenarel/gentoo
            }
            [[ -d "$HOME/coding/git/gentoo/guru" ]] || {
                git clone -b dev --depth 1 git@git.gentoo.org:repo/proj/guru.git "$HOME/coding/git/gentoo/guru"
                git -C "$HOME/coding/git/gentoo/guru" remote add distfiles git@github.com:ingenarel/guru-depfiles.git
                git -C "$HOME/coding/git/gentoo/guru" config --local pull.ff only
                git -C "$HOME/coding/git/gentoo/guru" config --local pull.rebase merges
                git -C "$HOME/coding/git/gentoo/guru" config --local commit.gpgsign 1
                git -C "$HOME/coding/git/gentoo/guru" config --local push.gpgsign 1
            }
        }
    }


    safelink "$scriptDir/programs/greetd/config.toml" "/etc/greetd/config.toml" 1
    [[ ! -d "/etc/greetd/sessions" ]] && sudo mkdir --parents /etc/greetd/sessions
    sudo cp $scriptDir/programs/greetd/sessions/*.desktop  "/etc/greetd/sessions"
}

setupConfigs
setSudoConfigs
"$scriptDir/mimes.sh"

git -C "$scriptDir/.." submodule init
git -C "$scriptDir/.." submodule update

"$scriptDir/../utils/gitPost.sh" "$scriptDir/.."

git -C "$scriptDir/.." submodule foreach '"$toplevel/utils/gitPost.sh" "$toplevel/$sm_path"'

git -C "$scriptDir/programs/neovim/myPlugins/metapack.nvim" switch dev
