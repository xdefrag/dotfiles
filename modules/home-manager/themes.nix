{ pkgs, ... }:
let
  fish-theme-ayu-dark = builtins.fetchurl {
    url = "https://github.com/edouard-lopez/ayu-theme.fish/blob/main/conf.d/ayu-dark.fish";
    sha256 = "1lbw63ld3bhcvwkdyb8c3qf9n310vx76qdgfbq17q27x0zk4nwih";
  };
in {
  home.file.".config/fish/conf.d/ayu_dark.fish".source = fish-theme-ayu-dark;

  home.packages = with pkgs; [
    nerd-fonts.iosevka
    feh
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Iosevka Nerd Font Mono" ];
      sansSerif = [ "Iosevka Nerd Font" ];
      serif = [ "Iosevka Nerd Font" ];
    };
  };
} 