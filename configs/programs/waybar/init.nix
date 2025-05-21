{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        waybar
    ];
    home-manager.users.ingenarel.home.file.".config/waybar/config.jsonc".source = ./config/config.json;
    home-manager.users.ingenarel.home.file.".config/waybar/style.css".source = ./config/style.css;
}
