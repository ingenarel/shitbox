#!/usr/bin/env bash
scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

setupConfigs(){
    ln -sf "$scriptDir/configs/programs/neovim/nvim"                                        "$HOME/.config/nvim"
    ln -sf "$scriptDir/configs/programs/lazygit/config"                                     "$HOME/.config/lazygit"
    ln -sf "$scriptDir/configs/programs/terminal/multiplexers/tmux/config"                  "$HOME/.config/tmux"
    ln -sf "$scriptDir/configs/programs/terminal/multiplexers/tmux/tmux-powerline-config"   "$HOME/.config/tmux-powerline"
    ln -sf "$scriptDir/configs/programs/zsh/config"                                         "$HOME/.config/zsh"
    ln -sf "$scriptDir/configs/programs/git/config"                                         "$HOME/.gitconfig"
    echo "source $HOME/.config/zsh/init.zsh" >                                              "$HOME/.zshrc"
    ln -sf "$scriptDir/configs/programs/yazi/config/alias"                                  "$HOME/.config/yazi/alias"
    ln -sf "$scriptDir/configs/programs/yazi/config/init.lua"                               "$HOME/.config/yazi/init.lua"
    ln -sf "$scriptDir/configs/programs/yazi/config/keymap.toml"                            "$HOME/.config/yazi/keymap.toml"
    ln -sf "$scriptDir/configs/programs/yazi/config/yazi.toml"                              "$HOME/.config/yazi/yazi.toml"
    ln -sf "$scriptDir/configs/programs/yazi/config/plugins/exifaudio.yazi"                 "$HOME/.config/yazi/plugins/exifaudio.yazi"
    ln -sf "$scriptDir/configs/programs/yazi/config/plugins/relative-motions.yazi"          "$HOME/.config/yazi/plugins/relative-motions.yazi"
    ln -sf "$scriptDir/configs/programs/yazi/config/plugins/starship.yazi"                  "$HOME/.config/yazi/plugins/starship.yazi"
    ln -sf "$scriptDir/configs/programs/yazi/config/plugins/plugins/git.yazi"               "$HOME/.config/yazi/plugins/git.yazi"
}

setupConfigs
