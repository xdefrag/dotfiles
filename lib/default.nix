{ lib }: {
  # Helper function to create user configuration
  mkUser = { username, email, homeDirectory ? "/home/${username}" }: {
    home = { 
      inherit username homeDirectory; 
      stateVersion = "23.11";
    };
    programs.git = { 
      userName = username; 
      userEmail = email; 
    };
  };
  
  # Helper function to enable configuration only on specific platform
  enableOnPlatform = platform: config:
    lib.mkIf (builtins.match ".*${platform}.*" builtins.currentSystem != null) config;
    
  # Helper function to enable configuration on Darwin
  enableOnDarwin = config:
    lib.mkIf (builtins.match ".*-darwin" builtins.currentSystem != null) config;
    
  # Helper function to enable configuration on Linux
  enableOnLinux = config:
    lib.mkIf (builtins.match ".*-linux" builtins.currentSystem != null) config;
} 