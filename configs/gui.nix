{
    inputs,
    pkgs,
    ...
}: {
    imports = [
        ./editing/init.nix
        ./gaming.nix
        ./window-manager.nix
        ./programs/terminal/emulators/init.nix
        ./programs/chatting/gui/init.nix
        ./programs/emulators/init.nix
        ./programs/browsers/zen.nix
    ];

    environment.systemPackages = with pkgs; [
        keepassxc
        pavucontrol
        qbittorrent
        vimiv-qt
        vlc
        zathura
    ];

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        pkgs.nerd-fonts.hack
    ];
}
