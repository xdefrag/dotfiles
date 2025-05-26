{ ... }: {
  programs.git = {
    enable = true;
    userName = "Stas Karkavin";
    userEmail = "me@xdefrag.dev";
    signing = {
      signByDefault = true;
      key = "DB956C1DD8450DBA8A203156301D5E00654A95E6";
    };
  };
} 