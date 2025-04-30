#!/usr/bin/env bash

update_stuff() {
    eval $1 &&
    {
        timeout --kill-after=4 --signal=TERM 4\
            notify-send "$2" || hyprctl notify 1 10000 "rgb(ff1ea3)" "fontsize:30 $2"
        timeout --kill-after=4 --signal=TERM 4\
            pw-play "$HOME/.config/tmux/sounds/notif.mp3"
    } ||
    {
        timeout --kill-after=4 --signal=TERM\
            notify-send "$2 failed!" "Updating $3..."
        timeout --kill-after=4 --signal=TERM\
            pw-play "$HOME/.config/tmux/sounds/error.mp3"
    }
}

if grep -qEi "gentoo" /etc/os-release ; then
    update_stuff "sudo emerge --sync"\
        "Synced repositories; updating eix cache..."
    update_stuff "eix-update"\
        "Updated eix cache; updating system packages..."
    update_stuff "sudo emerge --ask --verbose --update --deep --newuse @world --keep-going"\
        "Updated system packages; updating live ebuilds..."
    update_stuff "sudo smart-live-rebuild"\
        "Updated live ebuilds; updating yazi plugins..."

elif grep -qEi "arch" /etc/os-release ; then
    update_stuff "paru"\
        "Updated system packages; updating yazi plugins"

elif grep -qEi "nixos" /etc/os-release ; then
    update_stuff "nix flake update --flake $HOME/.config/nixos-config"\
        "Updated flakes; trying to commit..."
    update_stuff "git -C $HOME/.config/nixos-config add flake.nix flake.lock && git -C $HOME/.config/nixos-config commit -m '(auto): update'"\
        "Commited and pushed stuff; rebuilding nix"
    update_stuff "sudo nixos-rebuild switch --flake $HOME/.config/nixos-config#NixOSBaby"\
        "Rebuilded nix; updating yazi plugins..."

fi

update_stuff "ya pack --upgrade"\
    "Updated yazi plugins; updating zsh plugins..."
update_stuff "zsh -c 'source $HOME/.local/share/zinit/zinit.git/zinit.zsh && zinit update --all'"\
    "Updated zsh plugins; updating cargo packages..."
update_stuff "cargo install-update -a"\
    "Updated cargo packages; updating tmux plugins..."
update_stuff "$HOME/.tmux/plugins/tpm/bin/clean_plugins && $HOME/.tmux/plugins/tpm/bin/update_plugins all"\
    "Updated tmux plugins; updating neovim plugins..."
update_stuff "nvim --headless '+Lazy! clean' '+Lazy! update' '+MasonUpdate'"\
    "Updated neovim plugins"
