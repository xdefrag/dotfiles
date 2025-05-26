{ pkgs, ... }: {
  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Allow unfree packages (can be overridden per-host)
  nixpkgs.config.allowUnfree = false;

  # Basic system packages
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  # GPG configuration
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
} 