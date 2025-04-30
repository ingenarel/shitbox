{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        cava
    ];

    home-manager.users.ingenarel.home.file.".config/cava/config".source = ./config;
}
