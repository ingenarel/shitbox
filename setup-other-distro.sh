#!/usr/bin/env bash


setupConfigs(){
    ln -sf "$HOME/.config/nixos-config/configs/programs/neovim/nvim" "$HOME/.config/nvim"
    ln -sf "$HOME/.config/nixos-config/configs/programs/yazi/config" "$HOME/.config/yazi"
    ln -sf "$HOME/.config/nixos-config/configs/programs/lazygit/config" "$HOME/.config/lazygit"
    ln -sf "$HOME/.config/nixos-config/configs/programs/terminal/multiplexers/tmux/config" "$HOME/.config/tmux"
    ln -sf "$HOME/.config/nixos-config/configs/programs/terminal/multiplexers/tmux/tmux-powerline-config" "$HOME/.config/tmux-powerline"
    ln -sf "$HOME/.config/nixos-config/configs/programs/zsh/config" "$HOME/.config/zsh"
    echo "source $HOME/.config/zsh/init.zsh" > "$HOME/.zshrc"
}


setupConfigs
