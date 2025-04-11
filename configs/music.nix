{pkgs, ...}: {
    imports = [./programs/mpd.nix ./programs/cava/init.nix ./programs/ncmpcpp/init.nix];
    environment.systemPackages = with pkgs; [
        mediainfo
        mpc
        rmpc
        nicotine-plus
    ];
}
