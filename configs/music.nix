{pkgs, ...}: {
    imports = [./programs/mpd.nix];
    environment.systemPackages = with pkgs; [
        mediainfo
        mpc
        ncmpcpp
        rmpc
        cava
    ];
}
