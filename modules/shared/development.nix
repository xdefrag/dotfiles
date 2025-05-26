{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    # Build tools (Linux only)
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    busybox
    gnumake
    gcc
  ] ++ [
    # Search and text processing
    ripgrep
    ctags
    jq

    # Programming languages and tools
    nodejs_22
    typescript
    go
    
    # Language servers and formatters
    nixd
    nixfmt-classic
    gopls
    gotools
    gofumpt
    golangci-lint
    delve
    lua-language-server
    prettierd
    stylua
    taplo
    yamlfix
    typescript-language-server
  ];
} 