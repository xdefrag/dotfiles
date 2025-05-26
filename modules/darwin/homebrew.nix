{ ... }: {
  homebrew = {
    enable = true;
    
    onActivation.cleanup = "zap";
    
    # Homebrew taps
    taps = [
      "italomandara/cxpatcher"
      "wader/tap"
    ];
    
    # Homebrew formulae (консольные утилиты)
    brews = [
      # Development tools
      "git-gui"               # Git GUI
      "go-bindata"            # Go asset embedding
      "goose"                 # Database migration tool
      "hugo"                  # Static site generator
      "mockery"               # Go mock generator
      "protobuf"              # Protocol buffers
      "protoc-gen-go"         # Go protobuf generator
      
      # System utilities
      "fq"                    # jq for binary formats
      "make"                  # Make build tool
      "nnn"                   # File manager
      "pkgconf"               # Package configuration
      "ykman"                 # YubiKey manager CLI
      "ykpers"                # YubiKey personalization
      
      # Programming languages and runtimes
      "lua"                   # Lua language
      "luajit"                # LuaJIT
      "luarocks"              # Lua package manager
      "nvm"                   # Node version manager
    ];
    
    # Homebrew casks (GUI приложения)
    casks = [
      # Development
      "cursor"                # AI code editor
      "dbeaver-community"     # Database client
      "docker"                # Docker Desktop
      "figma"                 # Design tool
      "github"                # GitHub Desktop
      "iterm2"                # Terminal alternative
      "native-access"         # Native Instruments
      
      # Browsers
      "brave-browser"         # Privacy browser
      
      # Media and creativity
      "obs"                   # Streaming/recording
      "spotify"               # Music streaming
      "vlc"                   # Media player
      
      # Communication
      "discord"               # Gaming chat
      "viber"                 # Messaging
      
      # Productivity
      "obsidian"              # Note taking
      
      # System utilities
      "mac-mouse-fix"         # Mouse utility
      "macfuse"               # File system extension
      "rar"                   # RAR archiver
      "transmission"          # BitTorrent client
      "vb-cable"              # Virtual audio cable
      
      # Security and privacy
      "proton-drive"          # Proton Drive
      "proton-pass"           # Proton Pass
      "protonvpn"             # Proton VPN
      "yubico-yubikey-manager" # YubiKey manager
      
      # Finance and crypto
      "electrum"              # Bitcoin wallet
      "ledger-live"           # Ledger wallet
      
      # Gaming
      "crossover"             # Windows compatibility
      "cxpatcher"             # CrossOver patcher
      "devilutionx"           # Diablo port
      "openmw"                # Morrowind engine
      "steam"                 # Steam gaming
      
      # Misc
      "hot"                   # CPU temperature monitor
    ];
    
    # Mac App Store applications
    masApps = {
      # Добавьте сюда приложения из App Store, если они есть
      # Для получения ID используйте: mas search "App Name"
      # "Xcode" = 497799835;
    };
  };
} 