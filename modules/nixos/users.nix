{ ... }: {
  users.mutableUsers = false;
  
  # Define user accounts
  users.users.root.initialHashedPassword =
    "$y$j9T$ugg1nNi7vUk1.ho4y23fC1$9jSV3.xAitJIyz0W59pTlS1dgoDAPHJBnTlCMWpbYAD";
    
  users.users.xdefrag = {
    initialHashedPassword =
      "$y$j9T$ugg1nNi7vUk1.ho4y23fC1$9jSV3.xAitJIyz0W59pTlS1dgoDAPHJBnTlCMWpbYAD";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "input"
      "docker"
    ];
  };
} 