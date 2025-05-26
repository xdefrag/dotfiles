{ pkgs, lib, ... }: {
  imports = [
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/editors.nix
    ../../modules/home-manager/browsers.nix
    ../../modules/home-manager/media.nix
    ../../modules/home-manager/themes.nix
    ../../modules/home-manager/git.nix
    ../../modules/shared/development.nix
    ../../modules/shared/shell.nix
    ../../modules/shared/security.nix
  ];

  home = {
    username = "xdefrag";
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/xdefrag" else "/home/xdefrag";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  # i3 window manager configuration (Linux only)
  xsession.windowManager.i3 = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    config = {
      terminal = "${pkgs.alacritty}/bin/alacritty";
      fonts = {
        names = [ "Iosevka Nerd Font Mono" "monospace" ];
        style = "Bold Semi-Condensed";
        size = 18.0;
      };
      window = {
        titlebar = false;
        hideEdgeBorders = "smart";
      };
      startup = [{
        always = false;
        command = "exec ${pkgs.alacritty}/bin/alacritty";
        notification = false;
      }];
      assigns = {
        "1: main" = [{ class = "^Alacritty$"; }];
        "2: web" = [{ class = "^qutebrowser$"; }];
      };
      colors = {
        focused = {
          border = "#FFCC66";
          background = "#1F2430";
          text = "#CBCCC6";
          indicator = "#FFCC66";
          childBorder = "#FFCC66";
        };
        unfocused = {
          border = "#707A8C";
          background = "#1F2430";
          text = "#CBCCC6";
          indicator = "#707A8C";
          childBorder = "#707A8C";
        };
        urgent = {
          border = "#FF6B6B";
          background = "#1F2430";
          text = "#CBCCC6";
          indicator = "#FF6B6B";
          childBorder = "#FF6B6B";
        };
        background = "#1F2430";
      };
      bars = [{
        statusCommand = "${pkgs.i3status}/bin/i3status";
        colors = {
          background = "#1F2430";
          statusline = "#CBCCC6";
          separator = "#707A8C";
          focusedWorkspace = {
            border = "#FFCC66";
            background = "#1F2430";
            text = "#CBCCC6";
          };
          inactiveWorkspace = {
            border = "#707A8C";
            background = "#1F2430";
            text = "#CBCCC6";
          };
          urgentWorkspace = {
            border = "#FF6B6B";
            background = "#1F2430";
            text = "#CBCCC6";
          };
        };
      }];
    };
  };

  # Linux-specific settings
  xsession.initExtra = lib.mkIf pkgs.stdenv.isLinux ''
    ${pkgs.feh}/bin/feh --bg-scale "$HOME"/Pictures/wallpaper.jpg
  '';
} 