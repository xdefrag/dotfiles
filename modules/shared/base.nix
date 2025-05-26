{ pkgs, ... }: {
  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;

  # Garbage collection
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 0; Minute = 0; };
    options = "--delete-older-than 1w";
  };

  # Allow unfree packages (can be overridden per-host)
  nixpkgs.config.allowUnfree = false;

  # Basic system packages
  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
  ];

  # GPG configuration (only on NixOS)
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
} 