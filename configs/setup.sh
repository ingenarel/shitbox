#!/usr/bin/env bash
scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

source "$scriptDir/../utils/safelink.sh"

setSudoConfigs(){
    automountLine="$USER ALL=(ALL) NOPASSWD: /home/$USER/.config/shitbox/scripts/automount.sh"
    automountRegex="$USER ALL=\(ALL\) NOPASSWD: /home/$USER/.config/shitbox/scripts/automount.sh"
    automountConfig="/etc/sudoers.d/automount"
    sudo grep -qEi "$automountRegex" "$automountConfig" || echo "$automountLine" | sudo tee "$automountConfig"
}

setupConfigs(){
    [[ $HOME == "/root" ]] && HOME="/home/ingenarel"
    safelink "$scriptDir/programs/neovim/nvim"                                          "$HOME/.config/nvim"
    safelink "$scriptDir/programs/lazygit/config"                                       "$HOME/.config/lazygit"
    safelink "$scriptDir/programs/terminal/multiplexers/tmux/config"                    "$HOME/.config/tmux"
    safelink "$scriptDir/programs/terminal/multiplexers/tmux/tmux-powerline-config"     "$HOME/.config/tmux-powerline"
    safelink "$scriptDir/programs/zsh/config"                                           "$HOME/.config/zsh"
    safelink "$scriptDir/programs/git/config"                                           "$HOME/.gitconfig"
    safelink "$scriptDir/programs/music/cava/config"                                    "$HOME/.config/cava/config"
    safelink "$scriptDir/programs/music/ncmpcpp/config"                                 "$HOME/.config/ncmpcpp"
    safelink "$scriptDir/programs/neovim/lsp-configs/clangd"                            "$HOME/.config/clangd"
    safelink "$scriptDir/programs/terminal/emulators/foot/config"                       "$HOME/.config/foot"
    safelink "$scriptDir/programs/terminal/emulators/kitty/config"                      "$HOME/.config/kitty"
    safelink "$scriptDir/programs/terminal/multiplexers/zellij/config"                  "$HOME/.config/zellij"
    safelink "$scriptDir/programs/music/mpd"                                            "$HOME/.config/mpd"

    echo "source $HOME/.config/zsh/init.zsh" >                                          "$HOME/.zshrc"

    safelink "$scriptDir/programs/waybar/config.json"                                   "$HOME/.config/waybar/config.jsonc"
    safelink "$scriptDir/programs/waybar/style.css"                                     "$HOME/.config/waybar/style.css"

    safelink "$scriptDir/programs/yazi/config/alias"                                    "$HOME/.config/yazi/alias"
    safelink "$scriptDir/programs/yazi/config/init.lua"                                 "$HOME/.config/yazi/init.lua"
    safelink "$scriptDir/programs/yazi/config/keymap.toml"                              "$HOME/.config/yazi/keymap.toml"
    safelink "$scriptDir/programs/yazi/config/yazi.toml"                                "$HOME/.config/yazi/yazi.toml"
    safelink "$scriptDir/programs/yazi/config/plugins/exifaudio.yazi"                   "$HOME/.config/yazi/plugins/exifaudio.yazi"
    safelink "$scriptDir/programs/yazi/config/plugins/relative-motions.yazi"            "$HOME/.config/yazi/plugins/relative-motions.yazi"
    safelink "$scriptDir/programs/yazi/config/plugins/starship.yazi"                    "$HOME/.config/yazi/plugins/starship.yazi"
    safelink "$scriptDir/programs/yazi/config/plugins/plugins/git.yazi"                 "$HOME/.config/yazi/plugins/git.yazi"
    safelink "$scriptDir/programs/chatting/gui/discord/settings"                        "$HOME/.config/vesktop/settings"

    safelink "$scriptDir/programs/browsers/firefox/policies.json"                       "/etc/zen/policies/policies.json" 1
    safelink "$scriptDir/programs/browsers/firefox/profiles.ini"                        "$HOME/.zen/profiles.ini"
    mozlz4 -z "$scriptDir/programs/browsers/firefox/ingenarel/search.json"              "$scriptDir/programs/browsers/firefox/ingenarel/search.json.mozlz4"
    safelink "$scriptDir/programs/browsers/firefox/ingenarel/search.json.mozlz4"        "$HOME/.zen/ingenarel/search.json.mozlz4"

    {
        grep -E\
            '^user_pref\("[^_][^u][^s][^e][^r][^.][^j][^s][^.][^p][^a][^r][^r][^o][^t]'\
            "$scriptDir/programs/browsers/firefox/arkenfox/user.js"
        cat "$scriptDir/programs/browsers/firefox/zen.js"
    } | sort > "$scriptDir/programs/browsers/firefox/ingenarel/user.js"
    safelink "$scriptDir/programs/browsers/firefox/ingenarel/user.js"                   "$HOME/.zen/ingenarel/user.js"
    safelink "$scriptDir/programs/browsers/firefox/ingenarel/chrome/userChrome.css"     "$HOME/.zen/ingenarel/chrome/userChrome.css"

    safelink "$scriptDir/programs/hyprland/config"                                      "$HOME/.config/hypr"

    safelink "$scriptDir/programs/keyd/default.conf"                                    "/etc/keyd/default.conf" 1

    if grep -qEi "arch" /etc/os-release ; then
        safelink "$scriptDir/programs/pacman/pacman.conf"                               "/etc/pacman.conf" 1
    fi

    safelink "$scriptDir/programs/greetd/config.toml" "/etc/greetd/config.toml" 1
}

setupConfigs
setSudoConfigs

git -C "$scriptDir/.." submodule init
git -C "$scriptDir/.." submodule update

"$scriptDir/../utils/gitPost.sh" "$scriptDir/.."

git -C "$scriptDir/.." submodule foreach '"$toplevel/utils/gitPost.sh" "$toplevel/$sm_path"'


git -C "$scriptDir/programs/neovim/myPlugins/metapack.nvim" switch dev
