{ pkgs, ... }: {
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
        name = "sponge";
        src = pkgs.fishPlugins.sponge;
      }
    ];
    shellInitLast = ''
      set fish_greeting
      enable_ayu_theme_dark
    '';
  };
} 