{ ... }: {
  # Enable TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
} 