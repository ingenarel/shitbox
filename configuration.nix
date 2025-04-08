# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
    inputs,
    config,
    lib,
    pkgs,
    ...
}: {
    imports = [./hardware-configuration.nix ./configs/window-manager.nix ./configs/music.nix];

    boot.loader.grub = {
        device = "/dev/sda";
        memtest86.enable = true;
        # useOSProber = true;
    };

    networking = {
        hostName = "NixOSBaby";
        networkmanager.enable = true;
    };

    time.timeZone = "Asia/Dhaka";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {font = "Lat2-Terminus16";};

    nixpkgs.config.allowUnfree = true;

    virtualisation.waydroid.enable = true;

    users.users.ingenarel = {
        isNormalUser = true;
        extraGroups = ["wheel"];
    };

    nix = {
        settings = {
            experimental-features = ["nix-command" "flakes"];
            max-jobs = 1;
            cores = 2;
        };
        # daemonCPUSchedPolicy = "idle";
        # daemonIOSchedClass = "idle";
    };

    environment.systemPackages = with pkgs; [
        arch-install-scripts
        bash-language-server
        beautysh
        bemoji
        black
        btop
        clang
        clang-tools
        fastfetch
        fzf
        gcc
        git
        github-cli
        glab
        gnumake
        inputs.zen-browser.packages."${system}".twilight-official
        inputs.yazi.packages."${system}".default
        keepassxc
        keyd
        kitty
        lazygit
        lsd
        ltex-ls-plus
        lua-language-server
        lutris
        mtpfs
        mutt-wizard
        neomutt
        nil
        nodejs
        ntfs3g
        p7zip
        pavucontrol
        pyright
        python3
        python313Packages.debugpy
        qbittorrent
        qemu
        ripgrep
        rustup
        slurp
        starship
        stylua
        tmux
        unrar
        unzip
        usbutils
        vesktop
        vimiv-qt
        vlc
        w3m
        wget
        wineWowPackages.stable
        winetricks
        yaml-language-server
        yazi
        yt-dlp
        zathura
        zoxide
        zsh
        (
            (
                pkgs.ffmpeg-full.override {
                    withUnfree = true;
                    withOpengl = true;
                }
            )
            .overrideAttrs (_: {doCheck = false;})
        )
        (inputs.alejandra.packages."${system}".default.overrideAttrs (_: {doCheck = false;}))
    ];

    programs = {
        zsh.enable = true;
        nix-ld.enable = true;
        starship = {
            enable = true;
            settings = {
                status = {
                    disabled = false;
                };
            };
        };
        neovim = {
            enable = true;
            defaultEditor = true;
            package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        };
        fuse.userAllowOther = true;
    };

    users.defaultUserShell = pkgs.zsh;

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        pkgs.nerd-fonts.hack
    ];

    services = {
        keyd = {
            enable = true;
            keyboards = {
                default = {
                    ids = ["*"];
                    settings = {main = {rightalt = "esc";};};
                };
            };
        };
        pipewire = {
            enable = true;
            pulse.enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
            jack.enable = true;
            wireplumber.enable = true;
        };
        tailscale.enable = true;
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    system.stateVersion = "24.11"; # Did you read the comment?
}
