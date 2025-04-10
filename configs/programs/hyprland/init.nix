{
    inputs,
    pkgs,
    ...
}: {
    programs = {
        hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            xwayland.enable = true;
        };
        hyprlock.enable = true;
    };
    home-manager.users.ingenarel = {
        wayland.windowManager.hyprland = {
            enable = true;
            package = null;
            portalPackage = null;
            plugins = [inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo];
            extraConfig = builtins.readFile ./config/hyprland.conf;
        };
        home.file = {
            ".config/hypr/notes".source = ./config/notes;
            ".config/hypr/scripts".source = ./config/scripts;
            ".config/hypr/hyprlock.conf".source = ./config/hyprlock.conf;
        };
    };
}
