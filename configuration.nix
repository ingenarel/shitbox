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
    imports = [
        ./hardware-configuration.nix
        ./configs/gui.nix
        ./configs/music.nix
        ./configs/programs/git/init.nix
        ./configs/programs/neovim/init.nix
        ./configs/programs/zsh/init.nix
        ./configs/programs/clangd/init.nix
        ./configs/programs/kitty/init.nix
        ./configs/programs/tmux/init.nix
        ./configs/secrets/init.nix
    ];

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
        beautysh
        bemoji
        btop
        clang
        fastfetch
        fzf
        gcc
        gnumake
        gource
        inputs.yazi.packages."${system}".default
        keyd
        lsd
        mtpfs
        mutt-wizard
        neomutt
        nodejs
        ntfs3g
        p7zip
        pavucontrol
        pyright
        qemu
        ripgrep
        rustup
        starship
        unrar
        unzip
        usbutils
        w3m
        wget
        yt-dlp
        zoxide
        (
            (
                pkgs.ffmpeg-full.override {
                    withUnfree = true;
                    withOpengl = true;
                }
            )
            .overrideAttrs (_: {doCheck = false;})
        )
    ];

    programs = {
        nix-ld.enable = true;
        starship = {
            enable = true;
            settings = {
                status = {
                    disabled = false;
                };
            };
        };
        fuse.userAllowOther = true;
        gnupg.agent = {
            enable = true;
            pinentryPackage = pkgs.pinentry-curses;
        };
    };

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

    system.stateVersion = "24.11"; # Did you read the comment?
}
