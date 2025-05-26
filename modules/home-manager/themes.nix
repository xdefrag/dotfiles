{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.iosevka
    feh
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Iosevka Nerd Font Mono" ];
      sansSerif = [ "Iosevka Nerd Font" ];
      serif = [ "Iosevka Nerd Font" ];
    };
  };
} 