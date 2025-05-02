{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        cinny-desktop
    ];
}
