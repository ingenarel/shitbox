# vim: set ts=2 sw=2 sts=2:
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    alejandra.url = "github:kamadorueda/alejandra";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.NixOSBaby = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;}; # this is the important part
      modules = [
        ./configuration.nix
      ];
    };
  };

  # outputs = {
  #   self,
  #   nixpkgs,
  #   ...
  # }: let
  #   system = "x86_64-linux";
  #   pkgs = import nixpkgs {
  #     inherit system;
  #     config.allowUnfree = true;
  #   };
  #   lib = nixpkgs.lib;
  # in {
  #   nixosConfigurations = {
  #     NixOSBaby = lib.nixosSystem {
  #       inherit system;
  #       modules = [./configuration.nix];
  #     };
  #   };
  # };
}
