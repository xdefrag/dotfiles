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
      "git"                    # Git (можно перенести в home-manager)
      "git-gui"               # Git GUI
      "go"                     # Go (можно перенести в home-manager)
      "go-bindata"            # Go asset embedding
      "gofumpt"               # Go formatter (можно перенести в home-manager)
      "golangci-lint"         # Go linter (можно перенести в home-manager)
      "goose"                 # Database migration tool
      "gopls"                 # Go language server (можно перенести в home-manager)
      "hugo"                  # Static site generator
      "mockery"               # Go mock generator
      "protobuf"              # Protocol buffers
      "protoc-gen-go"         # Go protobuf generator
      
      # System utilities
      "curl"                  # HTTP client (можно перенести в home-manager)
      "fd"                    # Find alternative (можно перенести в home-manager)
      "fish"                  # Fish shell (можно перенести в home-manager)
      "fq"                    # jq for binary formats
      "fzf"                   # Fuzzy finder (можно перенести в home-manager)
      "jq"                    # JSON processor (можно перенести в home-manager)
      "make"                  # Make build tool
      "ncdu"                  # Disk usage analyzer
      "nnn"                   # File manager
      "p7zip"                 # 7-Zip archiver
      "pkgconf"               # Package configuration
      "ripgrep"               # Text search (можно перенести в home-manager)
      "tldr"                  # Simplified man pages
      "tmux"                  # Terminal multiplexer (можно перенести в home-manager)
      "tree"                  # Directory tree viewer
      "unzip"                 # ZIP extractor
      "wget"                  # HTTP downloader (можно перенести в home-manager)
      "ykman"                 # YubiKey manager CLI
      "ykpers"                # YubiKey personalization
      
      # Media and content
      "ffmpeg"                # Video/audio processing
      "mpv"                   # Media player
      "newsboat"              # RSS reader (можно перенести в home-manager)
      
      # Security and privacy
      "gnupg"                 # GPG (можно перенести в home-manager)
      "pass"                  # Password manager (можно перенести в home-manager)
      "pinentry"              # GPG PIN entry
      "pinentry-mac"          # macOS GPG PIN entry
      
      # Programming languages and runtimes
      "lua"                   # Lua language
      "lua-language-server"   # Lua language server (можно перенести в home-manager)
      "luajit"                # LuaJIT
      "luarocks"              # Lua package manager
      "node"                  # Node.js (можно перенести в home-manager)
      "nvm"                   # Node version manager
    ];
    
    # Homebrew casks (GUI приложения)
    casks = [
      # Development
      "alacritty"             # Terminal (можно перенести в home-manager)
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