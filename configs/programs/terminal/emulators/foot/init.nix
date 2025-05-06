{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        foot
    ];
    home-manager.users.ingenarel.home.file.".config/foot".source = ./config;
}
