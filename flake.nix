{
  description = "Multi-platform Nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
    let
      lib = nixpkgs.lib // import ./lib { inherit (nixpkgs) lib; };
      
      # Helper function for creating systems
      mkSystem = { system, modules, specialArgs ? {} }:
        if builtins.match ".*-darwin" system != null
        then nix-darwin.lib.darwinSystem {
          inherit system modules;
          specialArgs = specialArgs // { inherit inputs self; };
        }
        else nixpkgs.lib.nixosSystem {
          inherit system modules;
          specialArgs = specialArgs // { inherit inputs self; };
        };
    in {
      # NixOS configurations
      nixosConfigurations = {
        arkhope = mkSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/arkhope
            home-manager.nixosModules.home-manager
          ];
        };
      };

      # Darwin configurations
      darwinConfigurations = {
        ipstale = mkSystem {
          system = "aarch64-darwin";
          modules = [
            ./hosts/ipstale
            home-manager.darwinModules.home-manager
          ];
        };
      };

      # Standalone Home Manager configurations
      homeConfigurations = {
        "xdefrag@standalone" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ./users/xdefrag ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
} 