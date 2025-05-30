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
# Linux
home-manager switch --flake .#xdefrag@standalone

# macOS
home-manager switch --flake .#xdefrag@darwin
```

## Модули

### Shared modules (`modules/shared/`)
- **base.nix** - базовые настройки Nix (experimental features, gc, etc.)
- **colorscheme.nix** - единая цветовая схема Everforest Dark Soft для всех приложений
- **development.nix** - инструменты разработки (Go, Node.js, языковые серверы)
- **shell.nix** - настройки shell (fish, aliases, цветовая схема)
- **security.nix** - настройки безопасности (GPG, SSH, pass)
- **utilities.nix** - системные утилиты (curl, wget, fd, fzf, tree, etc.)
- **media.nix** - медиа утилиты (ffmpeg, mpv)

### Home Manager modules (`modules/home-manager/`)
- **terminal.nix** - терминальные приложения (alacritty, tmux) с цветовой схемой Everforest
- **editors.nix** - редакторы (neovim)
- **browsers.nix** - браузеры (qutebrowser)
- **media.nix** - медиа приложения (newsboat) с цветовой схемой Everforest
- **themes.nix** - шрифты (Iosevka Nerd Font)
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

## Миграция из Homebrew в Home Manager

В рамках оптимизации конфигурации были перенесены следующие пакеты из Homebrew в Home Manager:

### Перенесенные пакеты:
- **Development tools**: `git`, `go`, `gofumpt`, `golangci-lint`, `gopls`, `lua-language-server`, `node`
- **System utilities**: `curl`, `wget`, `fd`, `fzf`, `tree`, `ncdu`, `p7zip`, `unzip`, `tldr`, `ripgrep`, `jq`
- **Shell**: `fish`, `tmux`
- **Media**: `ffmpeg`, `mpv`, `newsboat`
- **Security**: `gnupg`, `pass`, `pinentry`
- **Terminal**: `alacritty`

### Новые модули:
- **`modules/shared/utilities.nix`** - системные утилиты с настройкой fzf
- **`modules/shared/media.nix`** - медиа утилиты с конфигурацией mpv
- **`modules/nixos/base.nix`** и **`modules/darwin/base.nix`** - разделенные системные настройки

### Преимущества миграции:
- Декларативная конфигурация всех инструментов
- Единообразные настройки на всех платформах
- Автоматическая настройка программ (fzf, mpv, gpg)
- Уменьшение зависимости от Homebrew
- Лучшая интеграция с Nix экосистемой

## Цветовая схема

Конфигурация использует единую цветовую схему **Everforest Dark Soft** для всех приложений:

- **Основа**: Зеленая цветовая схема, разработанная для комфорта глаз
- **Применение**: Fish shell, Alacritty, Tmux, Newsboat, i3 window manager
- **Файл**: `modules/shared/colorscheme.nix` - централизованное определение всех цветов
- **Источник**: [Everforest by sainnhe](https://github.com/sainnhe/everforest/blob/master/palette.md)

### Основные цвета:
- **Фон**: `#333C43` (dark soft background)
- **Текст**: `#D3C6AA` (основной текст)
- **Акцент**: `#83C092` (aqua - ссылки, выделения)
- **Ошибки**: `#E67E80` (red)
- **Успех**: `#A7C080` (green)
- **Предупреждения**: `#DBBC7F` (yellow)

## Преимущества

- **Переиспользование кода** - общие настройки используются на всех платформах
- **Модульность** - легко добавлять/удалять функциональность
- **Масштабируемость** - простое добавление новых хостов
- **Поддержка множества платформ** - единая конфигурация для Linux и macOS
- **Централизованное управление** - все настройки в одном месте
- **Условная логика** - разные настройки для разных платформ/хостов
- **Единая цветовая схема** - согласованный внешний вид всех приложений