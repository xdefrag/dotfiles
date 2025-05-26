{ pkgs, ... }: {
  # Enable the X11 windowing system
  services.xserver.enable = true;

  services.displayManager = {
    defaultSession = "none+i3";
    autoLogin = {
      enable = true;
      user = "xdefrag";
    };
  };

  services.xserver = {
    desktopManager.xterm.enable = false;
    windowManager.i3.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:ctrl_shift_toggle,ctrl:nocaps";

  services.libinput.touchpad.naturalScrolling = true;

  # Enable sound with PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable graphics
  hardware.graphics = { enable = true; };

  # Desktop packages
  environment.systemPackages = with pkgs; [
    dmenu
    session-desktop
    innoextract
    unzip
  ];
} 