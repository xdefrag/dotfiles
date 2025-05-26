{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./impermanence.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/services.nix
    ../../modules/nixos/base.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
  ];

  # Host-specific settings
  networking.hostName = "arkhope";
  time.timeZone = "Europe/Belgrade";

  # User configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.xdefrag = import ../../users/xdefrag;
  };

  system.stateVersion = "23.11";
} 