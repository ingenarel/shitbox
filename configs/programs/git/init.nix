{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        git
        github-cli
        glab
    ];
    imports = [../lazygit/init.nix];
    home-manager.users.ingenarel.home.file.".gitconfig".source = ./config;
}
