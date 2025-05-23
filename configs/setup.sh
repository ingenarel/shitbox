#!/usr/bin/env bash
scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

safelink(){
    [[ -d "$(realpath --canonicalize-missing "$2/..")" ]] || mkdir --parents "$2"
    [[ -d "$2" ]] || ln -sf "$1" "$2"
}

setupConfigs(){
    [[ $HOME == "/root" ]] && HOME="/home/ingenarel"
    safelink "$scriptDir/programs/neovim/nvim"                                          "$HOME/.config/nvim"
    safelink "$scriptDir/programs/lazygit/config"                                       "$HOME/.config/lazygit"
    safelink "$scriptDir/programs/terminal/multiplexers/tmux/config"                    "$HOME/.config/tmux"
    safelink "$scriptDir/programs/terminal/multiplexers/tmux/tmux-powerline-config"     "$HOME/.config/tmux-powerline"
    safelink "$scriptDir/programs/zsh/config"                                           "$HOME/.config/zsh"
    safelink "$scriptDir/programs/git/config"                                           "$HOME/.gitconfig"
    echo "source $HOME/.config/zsh/init.zsh" >                                          "$HOME/.zshrc"

    safelink "$scriptDir/programs/yazi/config/alias"                                    "$HOME/.config/yazi/alias"
    safelink "$scriptDir/programs/yazi/config/init.lua"                                 "$HOME/.config/yazi/init.lua"
    safelink "$scriptDir/programs/yazi/config/keymap.toml"                              "$HOME/.config/yazi/keymap.toml"
    safelink "$scriptDir/programs/yazi/config/yazi.toml"                                "$HOME/.config/yazi/yazi.toml"
    safelink "$scriptDir/programs/yazi/config/plugins/exifaudio.yazi"                   "$HOME/.config/yazi/plugins/exifaudio.yazi"
    safelink "$scriptDir/programs/yazi/config/plugins/relative-motions.yazi"            "$HOME/.config/yazi/plugins/relative-motions.yazi"
    safelink "$scriptDir/programs/yazi/config/plugins/starship.yazi"                    "$HOME/.config/yazi/plugins/starship.yazi"
    safelink "$scriptDir/programs/yazi/config/plugins/plugins/git.yazi"                 "$HOME/.config/yazi/plugins/git.yazi"
}

setupConfigs

git submodule init
git submodule update
