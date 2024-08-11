{
  description = "Minimalist Programmer's ThinkPad";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixos-hardware, impermanence, home-manager, ... }@inputs: {
      nixosConfigurations.arkhope = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit impermanence; };
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t480s
          ./impermanence.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.xdefrag = import ./home.nix;
          }
        ];
      };
    };
}
