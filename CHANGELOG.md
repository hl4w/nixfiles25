Version 1.5.0
--------------------------------------------------------
### New Features
- Add install-en.sh: English version of installation script
  - Same functionality as install.sh with English prompts
  - For international users who prefer English interface

### Improvements
- Optimize .bashrc configuration:
  - Add history management (HISTCONTROL, HISTSIZE, HISTTIMEFORMAT)
  - Enable bash options (histappend, globstar, autocd, cdspell)
  - Add path configuration for .local/bin, scripts, go/bin
  - Add conditional checks for eza, starship, go
  - Add more git aliases (gl, gd, gco, gb)
  - Add system management aliases (update, nix-update, nix-collect)
  - Add navigation aliases (.., ..., ....)
  - Add file existence checks for conditional aliases
- Add utility scripts:
  - `home/scripts/configs/cleanup.sh`: System cleanup script for `cleanup` alias
  - `home/scripts/configs/snapshot.sh`: System snapshot script for `ts` alias
  - `home/waybar/reload.sh`: Waybar reload script for `rw` alias

### Bug Fixes
- Fix install.sh/install-en.sh sed commands:
  - Escape dots in `user.name` and `user.email` patterns
  - Git user info modification now works correctly
- Remove unused `modules/noctalia.nix`:
  - Referred to deleted `noctalia` input, causing potential build failures
- Fix Home Manager file clobbering issue:
  - Add `force = true` to `xdg.configFile."fcitx5/conf/classicui.conf"` in `home/fcitx5/default.nix`
  - Add `force = true` to `xdg.configFile."Kvantum/kvantum.kvconfig"` in `home/gtkqt/default.nix`
  - Add text content to `xdg.configFile."gtk-4.0/gtk.css"` and `xdg.configFile."gtk-3.0/gtk.css"` in `home/gtkqt/default.nix`
- Fix install.sh/install-en.sh nix command execution:
  - Add `--extra-experimental-features "nix-command flakes"` flag to `nix flake update`
  - Solves "experimental Nix feature 'nix-command' is disabled" error
- Fix Home Manager config file conflicts:
  - Add `home-manager.backupFileExtension = "backup"` in `flake.nix`
  - Automatically backs up existing config files (e.g., `settings.ini` → `settings.ini.backup`)
  - Resolves "Existing file would be clobbered" errors for all Home Manager managed files
- Fix evaluation warnings:
  - Remove `nixpkgs.config.allowUnfree` from `home/core.nix` (conflicts with `useGlobalPkgs`)
  - Change `qt.platformTheme = "qtct"` to `qt.platformTheme.name = "qtct"` in `home/gtkqt/default.nix`
  - Eliminates `evaluation warning` messages during rebuild

### Configuration
- Enable non-free software installation:
  - Add `nixpkgs.config.allowUnfree = true` in hosts/default.nix (system level)
  - Allows installation of proprietary packages like Steam, NVIDIA drivers, etc.
- Set default values for username/hostname in flake.nix:
  - Changed from placeholder `<your-username>` to `nixos`
  - Allows direct deployment without running install.sh first
- Unify default username across all files:
  - install.sh: `hl4w` → `nixos`
  - install-en.sh: `hl4w` → `nixos`
  - flake.nix: already `nixos`
- Update users/home.nix Git config:
  - Replace hardcoded values with placeholders (`<your-name>`, `<your-email>`)
  - Will be automatically replaced by install.sh
- Update .bashrc aliases:
  - Fix `confw` alias to point to `modules.json` instead of `config.jsonc`
  - Add `rw` alias for Waybar reload
  - Add `cleanup`, `ts`, `ascii` aliases for utility scripts

### Documentation
- Update README.md with bilingual installation instructions
- Update README.md project structure to reflect removed files and added scripts

Version 1.4.0
--------------------------------------------------------
### Cleanup
- Remove unused flake inputs:
  - `hyprland-contrib`: Defined but never used in any module
  - `noctalia`: Defined but `modules/noctalia.nix` was not imported

### Documentation
- Update README.md:
  - Add repository clone instructions
  - Improve installation documentation with automated and manual methods
  - Add post-installation steps
  - Update version to 1.4.0

### Configuration
- Update flake.nix:
  - Replace hardcoded username/hostname with placeholders (`<your-username>`, `<your-hostname>`)
  - Add comments explaining how install.sh automates configuration

Version 1.3.0
--------------------------------------------------------
### New Features
- Add install.sh automated deployment script
  - Interactive prompt for username, hostname, and Git configuration
  - Auto-generates flake.lock
  - Deploys system configuration with nixos-rebuild switch
  - Color-coded output for better user experience

Version 1.2.0
--------------------------------------------------------
### Configuration Updates
- Update author information across all configuration files and scripts
  - Replace personal references with standardized author attribution "Silas Zhang (2026)"
  - Update flake.nix description to generic format
  - Update git user.name configuration to generic format
  - Standardize author comments in 47 configuration files including:
    - Shell scripts (.sh)
    - Configuration files (.conf, .rasi, .vim, .jsonc)
    - Style sheets (.css)
    - Python scripts (.py)
    - Waybar theme configurations
    - Hyprland configurations
    - Rofi configurations

Version 1.1.0
--------------------------------------------------------
### Documentation
- Add comprehensive Chinese comments to all configuration files
  - flake.nix: Nix configuration, inputs, outputs
  - hosts/default.nix: system configuration sections
  - modules/*.nix: hardware, hyprland, chinese modules
  - home/*.nix: user configuration modules
  - scripts/*.sh: automation scripts

### Optimization
- Optimize flake.nix: add nixConfig, restore official GitHub sources, add hyprland-contrib input, add formatter output
- Optimize modules: simplify hosts/default.nix, modules/hyprland.nix, modules/hardware.nix, modules/chinese.nix
- Optimize scripts: add error handling (set -euo pipefail), replace xclip with wl-copy (Wayland native), fix potential errors
- Clean up configuration files: remove redundant comments, unify code style and indentation

Version 1.0.0
--------------------------------------------------------
- update README.md
- delete rime-data and rime-ice
- update fcitx5 default.nix and add oh-my-rime
- add fcitx5-catppuccin(gitee) themes and classicui.conf
- del local rime-flypy