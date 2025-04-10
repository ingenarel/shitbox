{
    inputs,
    pkgs,
    ...
}: {
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        vimAlias = true;
        viAlias = true;
    };
    home-manager.users.ingenarel = {
        home.file.".config/nvim".source = ./config;
    };
}
