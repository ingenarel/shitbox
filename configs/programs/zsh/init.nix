{pkgs, ...}: {
    programs.zsh = {
        enable = true;
    };
    users.defaultUserShell = pkgs.zsh;
    home-manager.users.ingenarel.home.file.".config/zsh".source = ./config;
    home-manager.users.ingenarel.home.file.".zshrc".text = "source $HOME/.config/zsh/init.zsh";
}
