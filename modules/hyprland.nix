{ config, pkgs, ... }:

{
    
  services.xserver.enable = true; # 为了驱动、3D加速、输入设备能正常工作，而不是开X11。

  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      # Catppuccin 主题（mocha = 最深深蓝，macchiato = 墨绿+深蓝）
      theme = "sugar-dark";# 想深蓝就用：catppuccin-mocha-blue
      extraPackages = [ pkgs.sddm-sugar-dark ];
  };

  services.displayManager.sessionPackages = with pkgs; [
    hyprland
    #niri
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
  # 杀毒软件 ClamAV
  services.clamav = {
    daemon.enable = true;     # 必须开！
    updater.enable = true;    # 自动更新病毒库

    # 自动定时扫描
    scanner = {
      enable = true;
      interval = "weekly *-*-* 07:00:00"; # 每周日7点（systemd标准格式）
      scanDirectories = [ "/home" "/etc" "/usr" ];
    };
  };

  environment.variables = {
    # Wayland 通用 DPI（核心控制项，96=100%，120=125%，144=150%）
    WLR_DPI = "96";
    # 适配 QT/GTK 应用的缩放
    QT_SCALE_FACTOR = "1";
    GTK_SCALE = "1";
    # 强制 Wayland 渲染（避免部分应用 fallback 到 X11）
    #GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";

    GTK_THEME = "catppuccin-mocha";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_SCALE_OVERRIDE = "kvantum";

    EDITOR = "nvim";  # 默认编译器为neovim
  };

  environment.sessionVariables = {
    TERM = "xterm-256color";
    COLORTERM = "truecolor"; # 真彩色
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  

  environment.systemPackages = with pkgs;  [ 

    wget curl git neovim  zsh

    #xdg-desktop-portal-wlr # 用sway、river、wayfire
    xdg-utils
    xdg-user-dirs
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    kdePackages.xdg-desktop-portal-kde

    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
    hyprpolkitagent
    wlrctl
    waybar  rofi wlogout
    mako  dunst  wired

    grim  slurp swappy  imagemagick  ksnip swww ffmpeg_6-full
    wl-screenrec  wl-clipboard  wl-clip-persist cliphist

    sddm-sugar-dark

      # GTK 主题
    catppuccin-gtk
    flat-remix-gtk
    adwaita-icon-theme
    papirus-icon-theme
    kdePackages.qt6ct
    libsForQt5.qt5ct
    bibata-cursors
    catppuccin-kvantum
    nwg-look

    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ]; 

}