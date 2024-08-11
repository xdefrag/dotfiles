{ pkgs, ... }: {
  home.username = "xdefrag";
  home.homeDirectory = "/home/xdefrag";

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    brave
    syncthing
    unzip
    feh
    busybox
    innoextract
    tmux
    pass
    xclip
    fish
    git
    nodejs-slim
    ctags
    nixd
    nixfmt-classic
    gcc
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Iosevka Nerd Font Mono" ];
      sansSerif = [ "Iosevka Nerd Font" ];
      serif = [ "Iosevka Nerd Font" ];
    };
  };

  programs.git = {
    enable = true;
    userName = "Stas Karkavin";
    userEmail = "me@xdefrag.dev";
    signing = {
      signByDefault = true;
      key = "DB956C1DD8450DBA8A203156301D5E00654A95E6";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "Iosevka Nerd Font Mono";
        size = 10.0;
      };
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
