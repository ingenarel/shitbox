{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
    shellHook = ''
        alias nvim="XDG_CONFIG_HOME=$HOME/.config/nixos-config/configs/programs/neovim nvim"
        nvim
    '';
}
