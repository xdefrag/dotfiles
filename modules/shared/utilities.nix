{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Network utilities
    curl
    wget
    
    # File and search utilities
    fd
    fzf
    tree
    
    # Archive utilities
    p7zip
    unzip
    
    # System monitoring
    ncdu
    
    # Text processing
    tldr
  ];
  
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
} 