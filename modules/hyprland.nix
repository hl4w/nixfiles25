{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sugar-dark";
    extraPackages = [ pkgs.sddm-sugar-dark ];
  };

  services.displayManager.sessionPackages = with pkgs; [
    hyprland
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = false;
  };

  xdg.portal = {
    enable = true;
    config.common.default = [ "hyprland" ];
  };

  nixpkgs.config = {
    qt5.enable = true;
    qt5.platformTheme.name = "qt5ct";
    qt6.enable = true;
    qt6.platformTheme = "qt6ct";
  };

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    scanner = {
      enable = true;
      interval = "weekly *-*-* 07:00:00";
      scanDirectories = [ "/home" "/etc" "/usr" ];
    };
  };

  environment.variables = {
    WLR_DPI = "96";
    QT_SCALE_FACTOR = "1";
    GTK_SCALE = "1";
    QT_QPA_PLATFORM = "wayland";
    GTK_THEME = "catppuccin-mocha";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_SCALE_OVERRIDE = "kvantum";
    EDITOR = "nvim";
  };

  environment.sessionVariables = {
    TERM = "xterm-256color";
    COLORTERM = "truecolor";
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    wget curl git neovim zsh
    xdg-utils xdg-user-dirs xdg-desktop-portal
    xdg-desktop-portal-hyprland kdePackages.xdg-desktop-portal-kde
    pyprland hyprpicker hyprcursor hyprlock hypridle hyprpaper
    hyprsunset hyprpolkitagent wlrctl waybar rofi wlogout
    mako dunst wired grim slurp swappy imagemagick ksnip swww
    ffmpeg_6-full wl-screenrec wl-clipboard wl-clip-persist cliphist
    sddm-sugar-dark catppuccin-gtk flat-remix-gtk adwaita-icon-theme
    papirus-icon-theme kdePackages.qt6ct libsForQt5.qt5ct bibata-cursors
    catppuccin-kvantum nwg-look libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];
}