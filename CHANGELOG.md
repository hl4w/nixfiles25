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