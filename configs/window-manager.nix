{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        fuzzel
        grim
        libnotify
        swaynotificationcenter
        sweet
        swww
        wl-clipboard
        wtype
        slurp
    ];
    imports = [./programs/hyprland/init.nix ./programs/waybar/init.nix];

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
                user = "greeter";
            };
        };
    };

    systemd.services.greetd = {
        restartIfChanged = false;
    };
}
