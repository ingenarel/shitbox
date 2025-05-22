{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
    shellHook = ''
        alias nvim="XDG_CONFIG_HOME=$HOME/.config/shitbox/configs/programs/neovim nvim"
        nvim
    '';
}
