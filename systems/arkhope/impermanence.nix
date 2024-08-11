{ impermanence, ... }: {
  imports = [ impermanence.nixosModules.impermanence ];

  environment.persistence."/persist" = {
    directories = [
      "/etc/ssh"
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/cups"
      "/var/lib/fprint"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/db/sudo/lectured"
    ];
    files = [
      "/etc/ssh"
      "/var/log"
      "/var/lib/cups"
      "/var/lib/fprint"
      "/var/db/sudo/lectured"
    ];
    users.xdefrag = {
      directories = [
        "Downloads"
        "Documents"
        "Sync"
        "Music"
        "Video"
        "Games"
        ".local/share/nvim"
        ".config/nvim"
        ".config/alacritty"
        ".config/fish"
        ".config/syncthing"
        ".config/BraveSoftware"
        ".dotfiles"
      ];
      files = [ ".gitconfig" ".tmux.conf" ".config/i3/config" ];
    };
  };
}
