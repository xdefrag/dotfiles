{ pkgs, lib, ... }:
let
  colors = import ../../modules/shared/colorscheme.nix;
in {
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
    ../../modules/shared/utilities.nix
    ../../modules/shared/media.nix
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
          border = colors.everforest.aqua;
          background = colors.everforest.bg1;
          text = colors.everforest.fg;
          indicator = colors.everforest.aqua;
          childBorder = colors.everforest.aqua;
        };
        unfocused = {
          border = colors.everforest.grey0;
          background = colors.everforest.bg0;
          text = colors.everforest.fg;
          indicator = colors.everforest.grey0;
          childBorder = colors.everforest.grey0;
        };
        urgent = {
          border = colors.everforest.red;
          background = colors.everforest.bg0;
          text = colors.everforest.fg;
          indicator = colors.everforest.red;
          childBorder = colors.everforest.red;
        };
        background = colors.everforest.bg0;
      };
      bars = [{
        statusCommand = "${pkgs.i3status}/bin/i3status";
        colors = {
          background = colors.everforest.bg0;
          statusline = colors.everforest.fg;
          separator = colors.everforest.grey0;
          focusedWorkspace = {
            border = colors.everforest.aqua;
            background = colors.everforest.bg1;
            text = colors.everforest.fg;
          };
          inactiveWorkspace = {
            border = colors.everforest.grey0;
            background = colors.everforest.bg0;
            text = colors.everforest.fg;
          };
          urgentWorkspace = {
            border = colors.everforest.red;
            background = colors.everforest.bg0;
            text = colors.everforest.fg;
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