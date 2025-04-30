{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        zellij
    ];
    home-manager.users.ingenarel.home.file = {
        ".config/zellij".source = ./config;
    };
}
