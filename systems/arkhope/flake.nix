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
  };

  outputs = { nixpkgs, nixos-hardware, impermanence, ... }@inputs: {
    nixosConfigurations.arkhope = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit impermanence; };
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-t480s
        ./impermanence.nix
      ];
    };
  };
}
