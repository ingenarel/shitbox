{
    config,
    pkgs,
    ...
}: {
    home.username = "ingenarel";
    home.homeDirectory = "/home/ingenarel";

    home.stateVersion = "24.11";

    programs.home-manager.enable = true;
}
