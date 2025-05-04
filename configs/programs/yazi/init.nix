{
    pkgs,
    inputs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        inputs.yazi.packages."${system}".default
    ];
    home-manager.users.ingenarel.home.file = {
        ".config/yazi/alias".source = ./config/alias;
        ".config/yazi/init.lua".source = ./config/init.lua;
        ".config/yazi/keymap.toml".source = ./config/keymap.toml;
        ".config/yazi/yazi.toml".source = ./config/yazi.toml;
    };
}
