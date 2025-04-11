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
    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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
