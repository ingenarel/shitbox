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
        ".config/yazi/plugins/exifaudio.yazi".source = ./config/plugins/exifaudio.yazi;
        ".config/yazi/plugins/relative-motions.yazi".source = ./config/plugins/relative-motions.yazi;
        ".config/yazi/plugins/starship.yazi".source = ./config/plugins/starship.yazi;
        ".config/yazi/plugins/git.yazi".source = ./config/plugins/plugins/git.yazi;
    };
}
