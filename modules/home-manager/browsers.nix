{ pkgs, ... }: {
  programs.qutebrowser = {
    enable = true;
    searchEngines = { 
      nw = "https://wiki.nixos.org/index.php?=search={}"; 
    };
    settings = { 
      colors = { 
        webpage = { 
          darkmode = { 
            enabled = true; 
          }; 
        }; 
      }; 
    };
  };

  home.packages = with pkgs; [
    qutebrowser
  ];
} 