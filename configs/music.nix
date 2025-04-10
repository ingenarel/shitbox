{pkgs, ...}: {
    imports = [./programs/mpd.nix ./programs/cava/init.nix];
    environment.systemPackages = with pkgs; [
        mediainfo
        mpc
        ncmpcpp
        rmpc
        cava
        nicotine-plus
    ];
}
