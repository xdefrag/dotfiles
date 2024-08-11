{ config, lib, pkgs, ... }:
let
  alacritty-theme-ayu-dark = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/alacritty/alacritty-theme/master/themes/ayu_dark.toml";
    sha256 = "1385z7rh51wfyadrxk9j59xcinbgvfmw7cz4d5z6c9zaazkw72lc";
  };
  tmux-theme-ayu-dark = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/jibingeo/tmux-colors-ayu/master/tmuxcolors-dark.conf";
    sha256 = "1kvsjgx1dahb8pgy8ygankfq1d2slcbzmd4si5py251g1g2rbkxz";
  };
  fish-theme-ayu-dark = builtins.fetchurl {
    url =
      "https://github.com/edouard-lopez/ayu-theme.fish/blob/main/conf.d/ayu-dark.fish";
    sha256 = "0nlyfvdhjiafcvlpkf0xvvl2rf9qhvxs3qw2jamwp6zs8v95xl5h";
  };
  tmux-pomodoro-plus = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-pomodoro-plus";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "olimorris";
      repo = "tmux-pomodoro-plus";
      rev = "51fb321da594dab5a4baa532b53ea19b628e2822";
      sha256 = "sha256-LjhG2+DOAtLwBspOzoI2UDTgbUFWj7vvj6TQXqWw9z0=";
    };
  };
in {
  home.username = "xdefrag";
  home.homeDirectory = "/home/xdefrag";

  home.file.".config/alacritty/themes/ayu_dark.toml".source =
    alacritty-theme-ayu-dark;
  home.file.".config/tmux/themes/ayu_dark.conf".source = tmux-theme-ayu-dark;
  home.file.".config/fish/conf.d/ayu_dark.fish".source = fish-theme-ayu-dark;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    brave
    syncthing
    unzip
    feh
    innoextract
    pass
    xclip
    dmenu

    # programming
    busybox
    gnumake
    ctags
    nodejs_22
    typescript
    go
    gcc
    nixd
    nixfmt-classic
    gopls
    gotools
    gofumpt
    golangci-lint
    delve
    lua-language-server
    prettierd
    jq
    stylua
    taplo
    yamlfix
    typescript-language-server
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Iosevka Nerd Font Mono" ];
      sansSerif = [ "Iosevka Nerd Font" ];
      serif = [ "Iosevka Nerd Font" ];
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      v = "nvim";
      gst = "git status";
      gdc = "git diff --cached";
      gp = "git push";
      gpf = "git push --force";
      gri = "git rebase --interactive";
      gc = "git commit -S";
      gcm = "git commit -S -m";
      gca = "git commit --amend";
      ga = "git add";
      gaa = "git add .";
    };
    plugins = [
      {
        name = "hydro";
        src = pkgs.fishPlugins.hydro;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge;
      }
    ];
    shellInitLast = ''
      set fish_greeting
      enable_ayu_theme_dark
    '';
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
    plugins = with pkgs.tmuxPlugins; [ yank urlview tmux-pomodoro-plus ];
    extraConfig = lib.mkAfter ''
      source ~/.config/tmux/themes/ayu_dark.conf
    '';
  };

  # https://github.com/alacritty/alacritty-theme
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.home-manager.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "${pkgs.alacritty}/bin/alacritty";
      fonts = {
        names = [ "Iosevka Nerd Font Mono" "monospace" ];
        style = "Bold Semi-Condensed";
        size = 11.0;
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
        "2: web" = [{ class = "^Brave-browser$"; }];
      };
    };
  };

  xsession.initExtra = ''
    ${pkgs.feh}/bin/feh --bg-scale "$HOME"/Pictures/wallpaper.jpg
  '';

  services.syncthing.enable = true;

  home.stateVersion = "23.11";
}
