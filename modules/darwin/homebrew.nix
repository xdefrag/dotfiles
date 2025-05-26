{ ... }: {
  homebrew = {
    enable = true;
    
    # Cleanup unmanaged packages - ОСТОРОЖНО! Удаляет все неперечисленные пакеты
    onActivation.cleanup = "zap";
    
    # Homebrew taps
    taps = [];
    
    # Homebrew formulae (консольные утилиты)
    brews = [
      # Development tools
      "act"                    # GitHub Actions runner
      "awscli"                 # AWS CLI
      "gh"                     # GitHub CLI
      "git"                    # Git (можно перенести в home-manager)
      "git-gui"               # Git GUI
      "go"                     # Go (можно перенести в home-manager)
      "go-bindata"            # Go asset embedding
      "gofumpt"               # Go formatter (можно перенести в home-manager)
      "golangci-lint"         # Go linter (можно перенести в home-manager)
      "goose"                 # Database migration tool
      "gopls"                 # Go language server (можно перенести в home-manager)
      "gotests"               # Go test generator
      "gradle"                # Gradle build tool
      "helm"                  # Kubernetes package manager
      "hugo"                  # Static site generator
      "jenv"                  # Java version manager
      "kubefwd"               # Kubernetes port forwarding
      "mockery"               # Go mock generator
      "protobuf"              # Protocol buffers
      "protoc-gen-go"         # Go protobuf generator
      "sql-migrate"           # SQL migration tool
      "sqlc"                  # SQL code generator
      "staticcheck"           # Go static analyzer
      "vercel-cli"            # Vercel CLI
      
      # System utilities
      "aria2"                 # Download utility
      "bash"                  # Bash shell
      "coreutils"             # GNU core utilities
      "curl"                  # HTTP client (можно перенести в home-manager)
      "curl-impersonate"      # Curl with browser impersonation
      "fd"                    # Find alternative (можно перенести в home-manager)
      "fish"                  # Fish shell (можно перенести в home-manager)
      "fq"                    # jq for binary formats
      "fzf"                   # Fuzzy finder (можно перенести в home-manager)
      "gnu-getopt"            # GNU getopt
      "gnu-sed"               # GNU sed
      "htop"                  # Process viewer (можно перенести в home-manager)
      "jq"                    # JSON processor (можно перенести в home-manager)
      "make"                  # Make build tool
      "ncdu"                  # Disk usage analyzer
      "nnn"                   # File manager
      "p7zip"                 # 7-Zip archiver
      "rclone"                # Cloud storage sync
      "ripgrep"               # Text search (можно перенести в home-manager)
      "s3cmd"                 # S3 client
      "tldr"                  # Simplified man pages
      "tmux"                  # Terminal multiplexer (можно перенести в home-manager)
      "tree"                  # Directory tree viewer
      "unzip"                 # ZIP extractor
      "wget"                  # HTTP downloader (можно перенести в home-manager)
      "ykman"                 # YubiKey manager CLI
      "ykpers"                # YubiKey personalization
      "youtube-dl"            # YouTube downloader
      "yt-dlp"                # YouTube downloader (improved)
      
      # Media and content
      "cmus"                  # Music player
      "cmusfm"                # Last.fm scrobbler for cmus
      "ffmpeg"                # Video/audio processing
      "mpv"                   # Media player
      "newsboat"              # RSS reader (можно перенести в home-manager)
      
      # Security and privacy
      "gnupg"                 # GPG (можно перенести в home-manager)
      "pass"                  # Password manager (можно перенести в home-manager)
      "pinentry"              # GPG PIN entry
      "pinentry-mac"          # macOS GPG PIN entry
      "wireguard-go"          # WireGuard VPN
      "wireguard-tools"       # WireGuard tools
      
      # Blockchain and crypto
      "cointop"               # Cryptocurrency tracker
      "ipfs"                  # IPFS client
      
      # Communication
      "msmtp"                 # SMTP client
      "neomutt"               # Email client
      "notmuch"               # Email indexer
      "isync"                 # Email sync (mbsync)
      "w3m"                   # Text web browser
      "lynx"                  # Text web browser
      "weechat"               # IRC client
      
      # Games
      "brogue"                # Roguelike game
      "cataclysm"             # Cataclysm DDA
      "dosbox"                # DOS emulator
      
      # Programming languages and runtimes
      "dart-sdk"              # Dart SDK
      "deno"                  # Deno runtime
      "elixir"                # Elixir language
      "elixir-ls"             # Elixir language server
      "erlang"                # Erlang runtime
      "lua"                   # Lua language
      "lua-language-server"   # Lua language server (можно перенести в home-manager)
      "luajit"                # LuaJIT
      "luarocks"              # Lua package manager
      "node"                  # Node.js (можно перенести в home-manager)
      "nvm"                   # Node version manager
      "openjdk"               # OpenJDK
      "openjdk@11"            # OpenJDK 11
      "python@3.9"            # Python 3.9
      "python@3.10"           # Python 3.10
      "python@3.11"           # Python 3.11
      "python@3.12"           # Python 3.12
      "python@3.13"           # Python 3.13
      "ruby"                  # Ruby language
      
      # Databases and storage
      "etcd"                  # Key-value store
      "kafka"                 # Message broker
      "redis"                 # In-memory database
      "sqlite"                # SQLite database
      
      # Containerization and virtualization
      "podman"                # Container runtime
      
      # Scientific and data tools
      "jupyterlab"            # Jupyter notebooks
      "pandoc"                # Document converter
      "plantuml"              # UML diagrams
      "tesseract"             # OCR engine
      
      # Misc tools
      "aspell"                # Spell checker
      "bombadillo"            # Gopher/Gemini browser
      "browserpass"           # Browser password manager
      "cabextract"            # CAB file extractor
      "ctags"                 # Code indexing (можно перенести в home-manager)
      "fdroidserver"          # F-Droid server
      "grpcui"                # gRPC UI
      "grpcurl"               # gRPC curl
      "hopenpgp-tools"        # OpenPGP tools
      "innoextract"           # Inno Setup extractor
      "mercurial"             # Mercurial VCS
      "nicotine-plus"         # Soulseek client
      "pipx"                  # Python app installer
      "qrencode"              # QR code generator
      "winetricks"            # Wine helper
    ];
    
    # Homebrew casks (GUI приложения)
    casks = [
      # Development
      "alacritty"             # Terminal (можно перенести в home-manager)
      "android-platform-tools" # Android tools
      "android-studio"        # Android IDE
      "cursor"                # AI code editor
      "dbeaver-community"     # Database client
      "docker"                # Docker Desktop
      "figma"                 # Design tool
      "github"                # GitHub Desktop
      "godot"                 # Game engine
      "google-cloud-sdk"      # Google Cloud SDK
      "iterm2"                # Terminal alternative
      "native-access"         # Native Instruments
      
      # Browsers
      "brave-browser"         # Privacy browser
      "tor-browser"           # Tor browser
      
      # Media and creativity
      "blender"               # 3D modeling
      "cog"                   # Audio player
      "gimp"                  # Image editor
      "obs"                   # Streaming/recording
      "spotify"               # Music streaming
      "vlc"                   # Media player
      
      # Communication
      "discord"               # Gaming chat
      "signal"                # Secure messaging
      "viber"                 # Messaging
      "whatsapp"              # Messaging
      
      # Productivity
      "obsidian"              # Note taking
      "todoist"               # Task management
      
      # System utilities
      "applite"               # App installer
      "balenaetcher"          # USB/SD card writer
      "cyberduck"             # FTP/cloud client
      "mac-mouse-fix"         # Mouse utility
      "macfuse"               # File system extension
      "notunes"               # iTunes replacement
      "rar"                   # RAR archiver
      "transmission"          # BitTorrent client
      "vb-cable"              # Virtual audio cable
      
      # Security and privacy
      "proton-drive"          # Proton Drive
      "proton-pass"           # Proton Pass
      "protonvpn"             # Proton VPN
      "yubico-yubikey-manager" # YubiKey manager
      
      # Finance and crypto
      "bluewallet"            # Bitcoin wallet
      "electrum"              # Bitcoin wallet
      "ledger-live"           # Ledger wallet
      "monero-wallet"         # Monero wallet
      
      # Gaming
      "crossover"             # Windows compatibility
      "cxpatcher"             # CrossOver patcher
      "devilutionx"           # Diablo port
      "epic-games"            # Epic Games launcher
      "openmw"                # Morrowind engine
      "steam"                 # Steam gaming
      "wine-stable"           # Windows compatibility
      
      # Development environments
      "flutter"               # Flutter SDK
      "miniconda"             # Python environment
      "zulu"                  # OpenJDK distribution
      
      # Misc
      "altair-graphql-client" # GraphQL client
      "gstreamer-runtime"     # GStreamer
      "hot"                   # Folder colorizer
      "ipfs"                  # IPFS Desktop
      "lastfm"                # Last.fm scrobbler
      "musicbrainz-picard"    # Music tagger
      "session"               # Session messenger
    ];
    
    # Mac App Store applications
    masApps = {
      # Добавьте сюда приложения из App Store, если они есть
      # Для получения ID используйте: mas search "App Name"
      # "Xcode" = 497799835;
    };
  };
} 