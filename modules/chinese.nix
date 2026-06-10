{ config, pkgs, ... }:

{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_TIME = "en_US.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5
        kdePackages.fcitx5-qt
        kdePackages.fcitx5-configtool
        kdePackages.fcitx5-chinese-addons
        fcitx5-rime
        fcitx5-nord
        fcitx5-pinyin-zhwiki
        fcitx5-lua
        librime
      ];
      waylandFrontend = true;
    };
  };

  environment.sessionVariables = {
    QT_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "hyprland";
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    source-han-sans
    nerd-fonts.jetbrains-mono
    fira-code
    liberastika
    source-code-pro
    wqy_microhei
    font-awesome
    iosevka
  ];

  environment.systemPackages = with pkgs; [
    nuspell
    hyphen
    hunspell
    hunspellDicts.en_US
  ];
}
