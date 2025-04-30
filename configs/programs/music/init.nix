{pkgs, ...}: {
    imports = [./mpd.nix ./cava/init.nix ./ncmpcpp/init.nix];
    environment.systemPackages = with pkgs; [
        mediainfo
        mpc
        rmpc
        nicotine-plus
    ];
}
