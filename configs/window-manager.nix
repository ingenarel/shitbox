{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        fuzzel
        grim
        libnotify
        swaynotificationcenter
        sweet
        swww
        waybar
        wl-clipboard
        wtype
    ];
    imports = [./programs/hyprland/init.nix];

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
