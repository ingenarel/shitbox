{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        (flameshot.override {enableWlrSupport = true;})
        fuzzel
        libnotify
        swaynotificationcenter
        sweet
        swww
        wl-clipboard
        wtype
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
