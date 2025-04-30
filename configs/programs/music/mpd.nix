{...}: {
    home-manager.users.ingenarel.services.mpd = {
        enable = true;
        musicDirectory = "/home/ingenarel/Music";
        extraConfig = ''
            db_file            "/home/ingenarel/Music/mpd/database"

            # Uncomment to refresh the database whenever files in the music_directory are changed
            auto_update "yes"

            # Uncomment to enable the functionalities
            playlist_directory "/home/ingenarel/Music/mpd/playlists"
            pid_file           "/home/ingenarel/Music/mpd/pid"
            state_file         "/home/ingenarel/Music/state"
            sticker_file       "/home/ingenarel/Music/mpd/sticker.sql"
            audio_output {
                type "pipewire"
                name "My PipeWire Output"
            }
        '';
    };
}
