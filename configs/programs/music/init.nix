{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        mediainfo
        mpc
        rmpc
        nicotine-plus
        cava
        ncmpcpp
    ];
    home-manager.users.ingenarel.services.mpd = {
        enable = true;
        musicDirectory = "/home/ingenarel/Music";
    };
}
