{...}: {
    home-manager.users.ingenarel.home.file = {
        ".ssh/git.pub".source = ./ssh/git.pub;
        ".ssh/config".source = ./ssh/config;
    };
}
