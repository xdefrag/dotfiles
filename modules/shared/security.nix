{ pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    signing = {
      signByDefault = true;
      key = "DB956C1DD8450DBA8A203156301D5E00654A95E6";
    };
  };

  programs.gpg = {
    enable = true;
  };

  home.packages = with pkgs; [
    pass
    gnupg
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    pinentry  # GPG PIN entry (Linux only)
    xclip     # For clipboard integration (Linux only)
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    pinentry_mac  # macOS GPG PIN entry
  ];
} 