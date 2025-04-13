{
    inputs,
    pkgs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        bash-language-server
        black
        clang-tools
        inputs.alejandra.packages."${system}".default
        ltex-ls-plus
        lua-language-server
        nil
        (pkgs.python313.withPackages (python313Packages: [python313Packages.debugpy]))
        stylua
        yaml-language-server
    ];
}
