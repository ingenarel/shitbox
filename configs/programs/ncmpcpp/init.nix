{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        ncmpcpp
    ];
    home-manager.users.ingenarel.home.file.".config/ncmpcpp".source = ./config;
}
