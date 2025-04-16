{pkgs, ...}: {
    programs = {
        hyprland = {
            enable = true;
            xwayland.enable = true;
        };
        hyprlock.enable = true;
    };
    home-manager.users.ingenarel = {
        wayland.windowManager.hyprland = {
            enable = true;
            package = null;
            portalPackage = null;
            plugins = [pkgs.hyprlandPlugins.hyprexpo];
            extraConfig = builtins.readFile ./config/hyprland.conf;
        };
        home.file = {
            ".config/hypr/notes".source = ./config/notes;
            ".config/hypr/scripts".source = ./config/scripts;
            ".config/hypr/hyprlock.conf".source = ./config/hyprlock.conf;
        };
    };
}
