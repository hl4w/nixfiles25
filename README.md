
# HL4W - Nixfiles for Hyprland

An advanced configuration of Hyprland for NixOS based distributions. This repository contains the NixOS and Home Manager configuration files that build and manage systems. It uses Nix flakes for declarative, reproducible system deployments.

**Current Version:** 1.5.0
**NixOS Version:** 25.11

![screenshot](screenshots/v10/screenshots-1.png)

## Why Nix?

Nix is a powerful package manager and configuration management tool that enables:
- **Reproducible deployments**: Once configured, the system works exactly the same every time
- **Collaborative configurations**: Share your setup with others, and they can deploy identical environments
- **Easy rollbacks**: Previous system states can be recovered instantly
- **Declarative management**: Define what you want, and Nix figures out how to achieve it

## Project Structure

```
nixfiles/
├── flake.nix              # Main flake input and outputs
├── flake.lock             # Locked dependencies
├── home/                  # Home Manager configurations
│   ├── .bashrc            # Bash shell configuration
│   ├── core.nix           # Core home manager settings
│   ├── dunst/             # Notification daemon
│   ├── fastfetch/         # System info display tool
│   ├── fcitx5/            # Chinese input method (Rime)
│   ├── gtkqt/             # GTK/Qt theme configuration
│   ├── hypr/              # Hyprland (Wayland compositor)
│   │   ├── conf/          # Hyprland configuration modules
│   │   │   ├── animations/
│   │   │   ├── decorations/
│   │   │   ├── environments/
│   │   │   ├── keybindings/
│   │   │   ├── monitors/
│   │   │   ├── windowrules/
│   │   │   └── windows/
│   │   ├── scripts/       # Hyprland helper scripts
│   │   ├── hyprland.conf  # Main Hyprland config
│   │   ├── hypridle.conf  # Idle management
│   │   ├── hyprlock.conf  # Lock screen
│   │   └── hyprpaper.conf # Wallpaper manager
│   ├── nvim/              # Neovim editor
│   ├── programs/          # Various program configurations
│   │   ├── browsers.nix   # Browser settings
│   │   ├── common.nix     # Common packages
│   │   ├── git.nix        # Git configuration
│   │   ├── media.nix      # Media applications
│   │   └── xdg.nix        # XDG defaults
│   ├── rofi/              # Application launcher
│   ├── scripts/           # User scripts
│   │   └── configs/       # Utility scripts (cleanup, snapshot, etc.)
│   ├── settings/          # System settings (wallpaper engine, blur, etc.)
│   ├── shell/             # Shell configuration
│   ├── starship/          # Prompt configuration
│   ├── swappy/            # Screenshot tool
│   ├── wal/               # Wallpaper and colors (Pywal)
│   ├── wallpapers/        # Wallpaper images
│   ├── waybar/            # Status bar
│   │   ├── themes/        # Waybar themes (hl4w, hl4w-blur, etc.)
│   │   ├── reload.sh      # Waybar reload script
│   │   └── themeswitcher.sh
│   └── wlogout/           # Logout screen
├── hosts/                 # Host-specific configurations
│   ├── default.nix        # Main system configuration
│   └── hardware-configuration.nix  # Auto-generated hardware config
├── modules/               # NixOS modules
│   ├── ai-robot.nix       # AI/ML development tools
│   ├── auto-upgrade.nix   # Automatic system updates (optional)
│   ├── bootloader.nix     # Bootloader configuration
│   ├── chinese.nix        # Chinese locale and fonts
│   ├── dns.nix            # DNS configuration
│   ├── flatpak-module.nix # Flatpak support
│   ├── gc.nix             # Garbage collection
│   ├── hardware.nix       # Hardware drivers
│   ├── hyprland.nix       # Hyprland desktop module
│   ├── linux-kernel.nix   # Kernel configuration
│   └── virtualization.nix # Docker, KVM, QEMU (optional)
├── users/                 # User configurations
│   ├── home.nix           # Home Manager user config
│   └── nixos.nix          # NixOS user config
├── install.sh             # Chinese installation script
└── install-en.sh          # English installation script

```

## Key Components

### Desktop Environment
- **Hyprland**: Wayland compositor with extensive customization
- **Waybar**: Highly customizable status bar
- **Rofi**: Application launcher and dmenu replacement
- **Dunst**: Notification daemon

### Input Methods
- **Fcitx5 Rime**: Chinese input method with flypy schema

### Utilities
- **Fastfetch**: System information display
- **Swappy**: Screenshot annotation
- **Wallpaper Engine**: Dynamic wallpapers

### Scripts
- System management scripts (reboot, shutdown, suspend, lock)
- Wallpaper management
- Screenshot capture
- Theme switching

## Installation

### Prerequisites

1. Install NixOS 25.11 with the following options enabled:
   - `nix-command`
   - `flakes`

2. Clone this repository to your system:

```bash
git clone http://git.hl4w.com/hl4w/nixfiles25.git
cd nixfiles25
```

**Note:** This configuration uses Chinese mirror sources (Tsinghua and USTC) for faster package downloads in China. The mirrors are configured in `flake.nix` under `nixConfig.substituters`.

### Automated Installation (Recommended)

Use the interactive installation script for a guided setup. The script will prompt for configuration values and deploy the system automatically.

**Chinese Version:**
```bash
chmod +x install.sh
./install.sh
```

**English Version:**
```bash
chmod +x install-en.sh
./install-en.sh
```

The script will:
1. Prompt for **username**
2. Prompt for **hostname**
3. Prompt for **Git user name** and **email**
4. Display configuration summary and confirm before proceeding
5. Auto-generate `flake.lock` with dependency lockfile (includes `--extra-experimental-features` flag)
6. Deploy system configuration with `nixos-rebuild switch`

**Note:** The installation script automatically handles experimental Nix features (`nix-command` and `flakes`) by adding the necessary flags to `nix flake update`, so no manual configuration is required.

### Manual Installation

If you prefer manual setup, edit `flake.nix` to configure your username and hostname.

In the `outputs` section of `flake.nix`, find and modify these variables:

```nix
outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    # ... other config ...
    
    # 用户名和主机名
    # 修改后需重新运行 nixos-rebuild switch --flake .#<hostname>
    # 可通过 install.sh 脚本自动配置
    username = "nixos";
    hostname = "nixos";
    
    # ... rest of config ...
  in {
```

Key points about username and hostname:
- **`username`**: The system user name (used for Home Manager and user directories)
- **`hostname`**: The machine hostname (used in the flake output target: `#<hostname>`)

Then deploy the configuration:

```bash
# Generate lockfile (if not already present)
nix flake lock

# Rebuild the system - use your configured hostname here
sudo nixos-rebuild switch --flake .#<your-hostname>
```

Replace `<your-hostname>` with the hostname you set in `flake.nix`. For example, if you set `hostname = "desktop";`, use:

```bash
sudo nixos-rebuild switch --flake .#desktop
```

### Post-Installation

After successful deployment:
1. Log out and log back in to apply user configurations
2. The system will use the configured Hyprland desktop environment
3. Home Manager will manage user-specific configurations automatically

### Non-Free Software

This configuration enables installation of non-free (proprietary) software packages by default. Both system-level and user-level configurations include:

```nix
nixpkgs.config.allowUnfree = true;
```

This allows you to install packages like:
- **Steam** - Gaming platform
- **NVIDIA drivers** - Graphics drivers
- **VS Code** - Microsoft's editor
- Other proprietary software with unfree licenses

## Usage

### Rebuilding

After modifying any configuration files, rebuild the system:

```bash
sudo nixos-rebuild switch --flake .#
```

### Updating

Update all flake inputs:

```bash
sudo nixos-rebuild switch --flake .# --update
```

Or use the auto-upgrade module for automatic updates.

### Common Aliases

The `.bashrc` configuration includes useful aliases for daily operations:

| Alias | Command | Description |
|-------|---------|-------------|
| `c` | `clear` | Clear terminal |
| `nf`, `pf`, `ff` | `fastfetch` | Show system info |
| `..`, `...`, `....` | `cd ../..`, etc. | Quick navigation |
| `gs`, `ga`, `gc`, `gp`, `gpl` | Git commands | Git shortcuts |
| `update` | `sudo nixos-rebuild switch --flake .#` | System rebuild |
| `nix-collect` | `sudo nix-collect-garbage -d` | Clean old generations |
| `cleanup` | `~/.config/scripts/cleanup.sh` | System cleanup |
| `ts` | `~/.config/scripts/snapshot.sh` | System snapshot |
| `rw` | `~/.config/waybar/reload.sh` | Reload Waybar |
| `confb`, `confh`, `confw` | Edit config files | Quick config editing |

### File Clobbering

The configuration uses `home-manager.backupFileExtension = "backup"` to handle existing config file conflicts. When Home Manager encounters an existing file (e.g., `~/.config/gtk-4.0/settings.ini`), it will:
- Automatically rename the existing file to `*.backup` (e.g., `settings.ini.backup`)
- Continue deploying the new configuration

This approach is more robust than individual `force = true` settings and handles all Home Manager managed files uniformly.

**Note:** If you want to preserve your custom configurations, check the `.backup` files after deployment and merge any custom settings.

## Customization

### Waybar Themes

Multiple Waybar themes are available in `home/waybar/themes/`:
- **hl4w** (default) - Standard hl4w theme
- **hl4w-blur** - Blurred background variant
- **hl4w-blur-bottom** - Blurred background at bottom
- **hl4w-bottom** - Standard theme at bottom position
- **hl4w-minimal** - Minimalist variant
- **starter** - Beginner-friendly theme

Each theme has color variants: black, dark, light, white, colored, mixed.

Switch themes using the theme switcher script (`home/waybar/themeswitcher.sh`).

### Hyprland Configuration

Hyprland settings are highly customizable through configuration files in `home/hypr/conf/`:
- **animations/** - Animation presets (fast, high, moving, disabled)
- **decorations/** - Border and blur settings
- **environments/** - Environment variables (default, nvidia, kvm)
- **keybindings/** - Keyboard shortcuts
- **monitors/** - Monitor resolution presets (1366x768 to 3440x1440)
- **windowrules/** - Window-specific rules
- **windows/** - Window border styles

**Monitor Presets:** The configuration includes presets for common resolutions. Edit `home/hypr/conf/monitors/default.conf` or choose a preset that matches your display.

**NVIDIA Support:** Use `home/hypr/conf/environments/nvidia.conf` for NVIDIA GPU systems.

### Scripts

Various utility scripts are available in `home/scripts/` and `home/hypr/scripts/`:

**System Management:**
- `cleanup.sh`: System cleanup (remove old packages, cache)
- `snapshot.sh`: Create system snapshots for rollback
- `reload.sh` (Waybar): Reload Waybar configuration

**Hyprland Scripts:**
- Window management (resize, move, toggle)
- Power management (shutdown, reboot, suspend, lock)
- Monitor configuration
- Wallpaper and theme switching

**Utilities:**
- `figlet.sh`: ASCII art generator
- `cliphist.sh`: Clipboard history management
- `bravebookmarks.sh`: Brave browser bookmarks
- And more

## Development

### Code Formatting

This project uses `nixpkgs-fmt` for Nix code formatting. Run:

```bash
nix fmt
```

This will format all `.nix` files according to the standard style.

### Contributing

When modifying configurations:
1. Follow the existing comment style (Chinese comments with clear section headers)
2. Run `nix fmt` before committing
3. Test changes with `sudo nixos-rebuild switch --flake .#` before pushing

## License

This configuration is provided as-is for personal use. Feel free to study and adapt the configurations for your own NixOS setups.

## Author

Silas Zhang (2026)