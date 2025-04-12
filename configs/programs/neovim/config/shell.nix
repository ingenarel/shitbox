{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
    shellHook = ''
        export XDG_CONFIG_HOME=$HOME/.config/nixos-config/configs/programs/neovim
        export NVIM_APPNAME=config
        export DATA_SYMLINK="$HOME/.local/share/$NVIM_APPNAME"
        export STATE_SYMLINK="$HOME/.local/state/$NVIM_APPNAME"
        export CACHE_SYMLINK="$HOME/.cache/$NVIM_APPNAME"

        alias lazygit="lazygit -ucf $HOME/.config/lazygit/config.yml"

        [ -L "$DATA_SYMLINK" ] || ln -s "$HOME/.local/share/nvim" "$DATA_SYMLINK"
        [ -L "$STATE_SYMLINK" ] || ln -s "$HOME/.local/state/nvim" "$STATE_SYMLINK"
        [ -L "$CACHE_SYMLINK" ] || ln -s "$HOME/.cache/nvim" "$CACHE_SYMLINK"
        echo "created symlinks"

        cleanshit() {
            [ -L "$DATA_SYMLINK" ] && rm "$DATA_SYMLINK"
            [ -L "$STATE_SYMLINK" ] && rm "$STATE_SYMLINK"
            [ -L "$CACHE_SYMLINK" ] && rm "$CACHE_SYMLINK"
        }

        trap cleanshit EXIT

        nvim
    '';
}
