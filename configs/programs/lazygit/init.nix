{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        lazygit
    ];
    home-manager.users.ingenarel.home.file.".config/lazygit".source = ./config;
}
