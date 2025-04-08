{
    inputs,
    pkgs,
    ...
}: {
    imports = [./editing/init.nix ./gaming.nix ./window-manager.nix];

    environment.systemPackages = with pkgs; [
        inputs.zen-browser.packages."${system}".twilight-official
        keepassxc
        kitty
        qbittorrent
        vesktop
        vimiv-qt
        vlc
        zathura
    ];
}
