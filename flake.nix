{
    description = "My fucking system config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
        nixcord = {
            url = "github:kaylorben/nixcord";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        seto = {
            url = "github:unixpariah/seto";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        firefox-addons = {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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
