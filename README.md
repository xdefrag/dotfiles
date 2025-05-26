# Multi-platform Nix Configurations

Модульная конфигурация Nix с поддержкой NixOS (Linux) и nix-darwin (macOS).

## Структура

```
.
├── flake.nix           # Main flake with all systems
├── flake.lock          # Lock file
├── lib/                # Shared library functions
│   └── default.nix     # Helper functions
├── modules/            # Shared modules
│   ├── nixos/          # NixOS-specific modules
│   ├── darwin/         # Darwin-specific modules
│   ├── home-manager/   # Home Manager modules
│   └── shared/         # Cross-platform modules
├── hosts/              # Host-specific configurations
│   ├── arkhope/        # Linux laptop
│   └── ipstale/        # Darwin system
├── users/              # User configurations
│   └── xdefrag/        # User-specific settings
└── overlays/           # Nixpkgs overlays
    └── default.nix
```

## Использование

### NixOS (Linux)

Для системы arkhope:

```bash
sudo nixos-rebuild switch --flake .#arkhope
```

### Darwin (macOS)

Для системы ipstale:

```bash
darwin-rebuild switch --flake .#ipstale
```

### Standalone Home Manager

```bash
home-manager switch --flake .#xdefrag@standalone
```

## Модули

### Shared modules (`modules/shared/`)
- **base.nix** - базовые настройки Nix (experimental features, gc, etc.)
- **development.nix** - инструменты разработки (Go, Node.js, языковые серверы)
- **shell.nix** - настройки shell (fish, aliases)
- **security.nix** - настройки безопасности (GPG, SSH)

### Home Manager modules (`modules/home-manager/`)
- **terminal.nix** - терминальные приложения (alacritty, tmux)
- **editors.nix** - редакторы (neovim)
- **browsers.nix** - браузеры (qutebrowser)
- **media.nix** - медиа приложения (newsboat)
- **themes.nix** - темы и шрифты
- **git.nix** - конфигурация Git

### NixOS modules (`modules/nixos/`)
- **desktop.nix** - настройки рабочего стола (X11, i3)
- **networking.nix** - сетевые настройки
- **users.nix** - управление пользователями
- **services.nix** - системные сервисы

### Darwin modules (`modules/darwin/`)
- **system.nix** - системные настройки macOS
- **homebrew.nix** - управление Homebrew пакетами
- **fonts.nix** - управление шрифтами
- **security.nix** - настройки безопасности (TouchID)

## Добавление нового хоста

1. Создайте директорию в `hosts/`
2. Добавьте `default.nix` с импортами нужных модулей
3. Добавьте конфигурацию в `flake.nix`

Пример для нового Linux хоста:

```nix
# hosts/new-host/default.nix
{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/services.nix
    ../../modules/shared/base.nix
  ];

  networking.hostName = "new-host";
  time.timeZone = "Europe/Belgrade";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.xdefrag = import ../../users/xdefrag;
  };

  system.stateVersion = "23.11";
}
```

## Преимущества

- **Переиспользование кода** - общие настройки используются на всех платформах
- **Модульность** - легко добавлять/удалять функциональность
- **Масштабируемость** - простое добавление новых хостов
- **Поддержка множества платформ** - единая конфигурация для Linux и macOS
- **Централизованное управление** - все настройки в одном месте
- **Условная логика** - разные настройки для разных платформ/хостов