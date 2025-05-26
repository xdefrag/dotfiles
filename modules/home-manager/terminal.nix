{ lib, pkgs, ... }:
let
  alacritty-theme-ayu-dark = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/alacritty/alacritty-theme/master/themes/ayu_dark.toml";
    sha256 = "1385z7rh51wfyadrxk9j59xcinbgvfmw7cz4d5z6c9zaazkw72lc";
  };
  tmux-theme-ayu-dark = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/jibingeo/tmux-colors-ayu/master/tmuxcolors-dark.conf";
    sha256 = "1kvsjgx1dahb8pgy8ygankfq1d2slcbzmd4si5py251g1g2rbkxz";
  };
in {
  home.file.".config/alacritty/themes/ayu_dark.toml".source = alacritty-theme-ayu-dark;
  home.file.".config/tmux/themes/ayu_dark.conf".source = tmux-theme-ayu-dark;

  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "~/.config/alacritty/themes/ayu_dark.toml" ];
      font = {
        normal.family = "Iosevka Nerd Font Mono";
        size = 10.0;
      };
      shell = {
        program = "${pkgs.tmux}/bin/tmux";
        args = [ "new-session" "-A" "-s" "general" ];
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

      source ~/.config/tmux/themes/ayu_dark.conf
    '';
  };
} 