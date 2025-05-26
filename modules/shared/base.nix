{ pkgs, lib, ... }: {
  # Home Manager specific settings
  home.packages = with pkgs; [
    neovim
  ];

  # Enable experimental features for Home Manager
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
} 