{ lib, pkgs, ... }:
let
  colors = import ../shared/colorscheme.nix;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = colors.everforest.bg0;
          foreground = colors.everforest.fg;
        };
        normal = {
          black = colors.everforest.terminal.black;
          red = colors.everforest.terminal.red;
          green = colors.everforest.terminal.green;
          yellow = colors.everforest.terminal.yellow;
          blue = colors.everforest.terminal.blue;
          magenta = colors.everforest.terminal.magenta;
          cyan = colors.everforest.terminal.cyan;
          white = colors.everforest.terminal.white;
        };
        bright = {
          black = colors.everforest.terminal.bright_black;
          red = colors.everforest.terminal.bright_red;
          green = colors.everforest.terminal.bright_green;
          yellow = colors.everforest.terminal.bright_yellow;
          blue = colors.everforest.terminal.bright_blue;
          magenta = colors.everforest.terminal.bright_magenta;
          cyan = colors.everforest.terminal.bright_cyan;
          white = colors.everforest.terminal.bright_white;
        };
        cursor = {
          text = colors.everforest.bg0;
          cursor = colors.everforest.fg;
        };
        selection = {
          text = colors.everforest.fg;
          background = colors.everforest.bg2;
        };
      };
      font = {
        normal.family = "Iosevka Nerd Font Mono";
        size = 18.0;
      };
      env = {
        TERM = "alacritty";
      };
      terminal = {
        shell = {
          program = "${pkgs.tmux}/bin/tmux";
          args = [ "new-session" "-A" "-s" "general" ];
        };
      };
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-q";
    shell = "${pkgs.fish}/bin/fish";
    clock24 = true;
    keyMode = "vi";
    escapeTime = 0;
    mouse = false;
    sensibleOnTop = true;
    disableConfirmationPrompt = true;
    plugins = with pkgs.tmuxPlugins; [ yank urlview ];
    extraConfig = lib.mkAfter ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      
      # Ensure fish shell is properly initialized
      set -g default-shell "${pkgs.fish}/bin/fish"
      set -g default-command "${pkgs.fish}/bin/fish"
      
      # Fix for proper shell initialization
      set-environment -g SHELL "${pkgs.fish}/bin/fish"
      
      # Disable problematic terminal features that might cause escape sequences
      set -g allow-passthrough off
      set -g set-clipboard off

      # Everforest color scheme for tmux
      # Status bar
      set -g status-style "bg=${colors.everforest.statusline.bg},fg=${colors.everforest.statusline.fg}"
      set -g status-left-style "bg=${colors.everforest.statusline.accent},fg=${colors.everforest.bg0}"
      set -g status-right-style "bg=${colors.everforest.statusline.bg},fg=${colors.everforest.statusline.fg}"
      
      # Window status
      set -g window-status-style "bg=${colors.everforest.statusline.bg},fg=${colors.everforest.grey1}"
      set -g window-status-current-style "bg=${colors.everforest.statusline.accent},fg=${colors.everforest.bg0}"
      
      # Pane borders
      set -g pane-border-style "fg=${colors.everforest.grey0}"
      set -g pane-active-border-style "fg=${colors.everforest.statusline.accent}"
      
      # Message style
      set -g message-style "bg=${colors.everforest.yellow},fg=${colors.everforest.bg0}"
      set -g message-command-style "bg=${colors.everforest.orange},fg=${colors.everforest.bg0}"
      
      # Copy mode
      set -g mode-style "bg=${colors.everforest.bg2},fg=${colors.everforest.fg}"
    '';
  };
} 