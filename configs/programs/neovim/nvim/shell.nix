{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
    shellHook = ''
        alias lazygit="lazygit -ucf $HOME/.config/lazygit/config.yml"
        alias nvim="XDG_CONFIG_HOME=$HOME/.config/nixos-config/configs/programs/neovim nvim"
        nvim
    '';
}
