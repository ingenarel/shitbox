# THIS FILE HAS BEEN AUTOMATICALLY GENERATED BY METAPACK.NVIM!!!
# YOU SHOULD NOT EDIT THIS FILE, INSTEAD EDIT YOUR METAPACK.NVIM CONFIGURATION!!!


{ pkgs, inputs, ... }: {
    environment.systemPackages = with pkgs; [
        alejandra
        bash-language-server
        black
        clang-tools
        clang-tools
        jq
        ltex-ls-plus
        lua-language-server
        nil
        pyright
        rust-analyzer
        stylua
        yaml-language-server
        (pkgs.python313.withPackages (python313Packages: [
            python313Packages.debugpy
        ]))
    ];
}
