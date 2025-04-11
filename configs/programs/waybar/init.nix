{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        waybar
    ];
    home-manager.users.ingenarel.home.file.".config/waybar".source = ./config;
}
