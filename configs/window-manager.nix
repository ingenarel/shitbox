{
    inputs,
    pkgs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        # (flameshot.override {enableWlrSupport = true;})
        inputs.seto.packages.${pkgs.system}.default
        grim
        slurp
        fuzzel
        libnotify
        swaynotificationcenter
        sweet
        swww
        wl-clipboard
        wtype
        waybar
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
