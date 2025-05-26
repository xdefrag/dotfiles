{ pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    signing = {
      signByDefault = true;
      key = "DB956C1DD8450DBA8A203156301D5E00654A95E6";
    };
  };

  home.packages = with pkgs; [
    pass
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    xclip  # For clipboard integration (Linux only)
  ];
} 