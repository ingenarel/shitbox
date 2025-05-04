{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        kitty
    ];
    home-manager.users.ingenarel.home.file.".config/kitty".source = ./config;
}
