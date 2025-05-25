{ lib, pkgs, ... }:
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
in {
  home.username = "xdefrag";
  home.homeDirectory = "/home/xdefrag";

  home.file.".config/alacritty/themes/ayu_dark.toml".source =
    alacritty-theme-ayu-dark;
  home.file.".config/tmux/themes/ayu_dark.conf".source = tmux-theme-ayu-dark;
  home.file.".config/fish/conf.d/ayu_dark.fish".source = fish-theme-ayu-dark;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    qutebrowser
    syncthing
    unzip
    feh
    innoextract
    pass
    xclip
    dmenu
    session-desktop

    # programming
    busybox
    gnumake
    ripgrep
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
    plugins = with pkgs.tmuxPlugins; [ yank urlview ];
    extraConfig = lib.mkAfter ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"

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

  programs.qutebrowser = {
    enable = true;
    searchEngines = { nw = "https://wiki.nixos.org/index.php?=search={}"; };
    settings = { colors = { webpage = { darkmode = { enabled = true; }; }; }; };
  };

  # TODO: https://abhinandhs.in/articles/setting-up-newsboat-the-nix-way
  programs.newsboat = {
    enable = true;
    urls = [
      {
        title = "Mises Institute";
        tags = [ "libertarianism" ];
        url = "https://mises.org/rss.xml";
      }
      {
        title = "Cato Institute";
        tags = [ "libertarianism" ];
        url = "https://www.cato.org/rss.xml";
      }
      {
        title = "Gray Mirror";
        tags = [ "nrx" ];
        url = "https://graymirror.substack.com/feed";
      }
      {
        title = "NixOS Newsletters";
        tags = [ "nixos" "software" ];
        url = "https://nixos.org/blog/newsletters-rss.xml";
      }
      {
        title = "NixOS Announcements";
        tags = [ "nixos" "software" ];
        url = "https://nixos.org/blog/announcements-rss.xml";
      }
      {
        title = "NixOS Stories";
        tags = [ "nixos" "software" ];
        url = "https://nixos.org/blog/stories-rss.xml";
      }
      {
        title = "Neovim News";
        tags = [ "neovim" "software" ];
        url = "https://neovim.io/news.xml";
      }
      {
        title = "Golang Weekly";
        tags = [ "golang" "software" ];
        url = "https://cprss.s3.amazonaws.com/golangweekly.com.xml";
      }
      {
        title = "Stellar Blog";
        tags = [ "stellar" "software" ];
        url = "https://stellar.org/blog/rss.xml";
      }
      {
        title = "Liberland Press";
        tags = [ "liberland" "dao" "focj" ];
        url = "https://liberlandpress.com/feed/";
      }
      {
        title = "Golang Releases";
        tags = [ "golang" "software" "github" ];
        url = "https://github.com/golang/go/releases.atom";
      }
      {
        title = "Watermill Releases";
        tags = [ "golang" "software" "github" ];
        url = "https://github.com/ThreeDotsLabs/watermill/releases.atom";
      }
      {
        title = "Lo Releases";
        tags = [ "golang" "software" "github" ];
        url = "https://github.com/samber/lo/releases.atom";
      }
    ];
    extraConfig = ''
      refresh-on-startup yes
      reload-threads 100

      show-read-feeds yes
      show-read-articles yes

      color info default default reverse
      color listnormal_unread yellow default
      color listfocus blue default reverse bold
      color listfocus_unread blue default reverse bold

      text-width 80

      bind-key h quit
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key H prev-feed
      bind-key L next-feed
      bind-key g home
      bind-key G end
      bind-key SPACE macro-prefix 
      bind-key b bookmark 
      bind-key ^F pagedown 
      bind-key ^B pageup 
      bind-key ^H toggle-show-read-feeds
    '';
  };

  programs.home-manager.enable = true;

  xsession.windowManager.i3 = {
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

  xsession.initExtra = ''
    ${pkgs.feh}/bin/feh --bg-scale "$HOME"/Pictures/wallpaper.jpg
  '';

  home.stateVersion = "23.11";
}
