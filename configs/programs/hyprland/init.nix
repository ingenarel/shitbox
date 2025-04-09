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
    home-manager.users.ingenarel.wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        systemd.enable = false;
    };
}
