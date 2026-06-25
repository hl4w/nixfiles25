
# HL4W - Nixfiles for Hyprland

An advanced configuration of Hyprland for NixOS based distributions. This repository contains the NixOS and Home Manager configuration files that build and manage systems. It uses Nix flakes for declarative, reproducible system deployments.

**Current Version:** 1.5.0

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
│   ├── nvim/              # Neovim editor
│   ├── programs/          # Various program configurations
│   ├── rofi/              # Application launcher
│   ├── scripts/           # User scripts
│   │   └── configs/       # Utility scripts (cleanup, snapshot, etc.)
│   ├── settings/          # System settings
│   ├── shell/             # Shell configuration
│   ├── starship/          # Prompt configuration
│   ├── swappy/            # Screenshot tool
│   ├── wal/               # Wallpaper and colors
│   ├── wallpapers/        # Wallpaper images
│   ├── waybar/            # Status bar
│   │   ├── themes/        # Waybar themes
│   │   ├── reload.sh      # Waybar reload script
│   │   └── themeswitcher.sh
│   └── wlogout/           # Logout screen
├── hosts/                 # Host-specific configurations
│   ├── default.nix
│   └── hardware-configuration.nix
├── modules/               # NixOS modules
│   ├── ai-robot.nix
│   ├── auto-upgrade.nix
│   ├── bootloader.nix
│   ├── chinese.nix
│   ├── dns.nix
│   ├── flatpak-module.nix
│   ├── gc.nix
│   ├── hardware.nix
│   ├── hyprland.nix
│   ├── linux-kernel.nix
│   └── virtualization.nix
├── users/                 # User configurations
│   ├── home.nix
│   └── nixos.nix
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

1. Install NixOS with the following options enabled:
   - `nix-command`
   - `flakes`

2. Clone this repository to your system:

```bash
git clone http://git.hl4w.com/hl4w/nixfiles25.git
cd nixfiles25
```

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
5. Auto-generate `flake.lock` with dependency lockfile
6. Deploy system configuration with `nixos-rebuild switch`

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

If you encounter "Existing file would be clobbered" errors during deployment, the configuration now includes `force = true` for critical XDG config files:
- `fcitx5/conf/classicui.conf`
- `gtk-4.0/gtk.css`, `gtk-3.0/gtk.css`
- `Kvantum/kvantum.kvconfig`

This ensures Home Manager can overwrite existing configuration files during deployment.

## Customization

### Waybar Themes

Multiple Waybar themes are available in `home/waybar/themes/`:
- hl4w (default)
- hl4w-blur
- hl4w-blur-bottom
- hl4w-minimal
- starter

Switch themes using the theme switcher script.

### Hyprland Configuration

Hyprland settings are highly customizable through configuration files in `home/hypr/conf/`:
- Animations
- Decorations
- Keybindings
- Monitor setups
- Window rules

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

## License

This configuration is provided as-is for personal use. Feel free to study and adapt the configurations for your own NixOS setups.