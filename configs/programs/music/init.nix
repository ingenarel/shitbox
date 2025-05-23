{pkgs, ...}: {
    imports = [./mpd.nix];
    environment.systemPackages = with pkgs; [
        mediainfo
        mpc
        rmpc
        nicotine-plus
        cava
        ncmpcpp
    ];
}
