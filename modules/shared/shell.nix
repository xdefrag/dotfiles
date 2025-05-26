{ pkgs, ... }:
let
  colors = import ./colorscheme.nix;
in {
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
      {
        name = "bass";
        src = pkgs.fishPlugins.bass;
      }
    ];
    shellInit = ''
      # Add Home Manager paths to PATH
      if test -d "/etc/profiles/per-user/$USER/bin"
        fish_add_path --prepend "/etc/profiles/per-user/$USER/bin"
      end
      if test -d "$HOME/.nix-profile/bin"
        fish_add_path --prepend "$HOME/.nix-profile/bin"
      end
      
      # Source Home Manager session variables using bass (for bash compatibility)
      if command -q bass
        if test -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
          bass source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        else if test -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
          bass source "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
        end
      else
        # Fallback: manually set common environment variables
        set -gx EDITOR nvim
      end
    '';
    shellInitLast = ''
      set fish_greeting
      
      # Everforest color scheme for fish
      set -g fish_color_normal ${colors.everforest.fg}
      set -g fish_color_command ${colors.everforest.green}
      set -g fish_color_keyword ${colors.everforest.purple}
      set -g fish_color_quote ${colors.everforest.yellow}
      set -g fish_color_redirection ${colors.everforest.aqua}
      set -g fish_color_end ${colors.everforest.orange}
      set -g fish_color_error ${colors.everforest.red}
      set -g fish_color_param ${colors.everforest.fg}
      set -g fish_color_comment ${colors.everforest.grey0}
      set -g fish_color_selection --background=${colors.everforest.bg2}
      set -g fish_color_search_match --background=${colors.everforest.bg3}
      set -g fish_color_operator ${colors.everforest.aqua}
      set -g fish_color_escape ${colors.everforest.purple}
      set -g fish_color_autosuggestion ${colors.everforest.grey0}
      
      # Prompt colors
      set -g fish_color_cwd ${colors.everforest.blue}
      set -g fish_color_user ${colors.everforest.green}
      set -g fish_color_host ${colors.everforest.aqua}
      
      # Pager colors
      set -g fish_pager_color_progress ${colors.everforest.grey0}
      set -g fish_pager_color_prefix ${colors.everforest.aqua}
      set -g fish_pager_color_completion ${colors.everforest.fg}
      set -g fish_pager_color_description ${colors.everforest.grey1}
    '';
  };
} 