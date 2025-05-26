{ ... }: {
  # Enable Docker
  virtualisation.docker.enable = true;

  # Boot loader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
} 