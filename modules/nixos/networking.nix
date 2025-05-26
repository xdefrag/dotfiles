{ ... }: {
  # Enable NetworkManager for easy network management
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
    };
  };
} 