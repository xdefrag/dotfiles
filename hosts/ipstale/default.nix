{ inputs, ... }: {
  imports = [
    ../../modules/darwin/system.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/fonts.nix
    ../../modules/darwin/security.nix
    ../../modules/darwin/base.nix
  ];

  # Host-specific settings
  networking.hostName = "ipstale";
  system.primaryUser = "xdefrag";

  # Fix for nixbld group GID mismatch
  ids.gids.nixbld = 350;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";

  # User configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.xdefrag = import ../../users/xdefrag;
  };

  # Declare the user that will be running nix-darwin
  users.users.xdefrag = {
    name = "xdefrag";
    home = "/Users/xdefrag";
  };
} 