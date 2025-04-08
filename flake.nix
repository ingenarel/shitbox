{
    description = "My fucking system config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # hyprland-plugins = {
        #   url = "github:hyprwm/hyprland-plugins";
        #   inputs.hyprland.follows = "hyprland";
        # };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        neovim-nightly-overlay = {
            url = "github:nix-community/neovim-nightly-overlay";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        alejandra.url = "github:kamadorueda/alejandra";
        yazi = {
            url = "github:sxyazi/yazi";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        nixpkgs,
        home-manager,
        ...
    } @ inputs: {
        nixosConfigurations.NixOSBaby = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;}; # this is the important part
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.ingenarel = ./home.nix;
                }
            ];
        };
    };
}
