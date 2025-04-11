{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        git
        github-cli
        glab
    ];
    imports = [./lazygit/init.nix];
    home-manager.users.ingenarel.programs.git = {
        enable = true;
        userName = "ingenarel";
        userEmail = "ingenarelitems@gmail.com";
    };
}
