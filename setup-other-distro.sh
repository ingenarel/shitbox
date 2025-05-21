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
}

setupConfigs
