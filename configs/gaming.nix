{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        lutris
        wineWowPackages.stable
        winetricks
    ];
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
}
