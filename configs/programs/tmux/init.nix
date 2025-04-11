{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        tmux
    ];
    home-manager.users.ingenarel.home.file = {
        ".config/tmux".source = ./config;
        ".config/tmux-powerline".source = ./tmux-powerline-config;
    };
}
