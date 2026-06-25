{ config, pkgs, lib, ... }:

{
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk;
      name = "Catppuccin-Mocha-Dark";
    };
    iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
      name = "Catppuccin-Mocha";
    };
  };

  # 启用 dconf
  dconf.enable = true;

  # 强制覆盖已存在的 GTK 配置文件
  xdg.configFile."gtk-4.0/gtk.css".force = true;
  xdg.configFile."gtk-3.0/gtk.css".force = true;

  xdg.configFile."Kvantum/kvantum.kvconfig" = {
     force = true;
     text = ''
    [General]
    theme=Catppuccin-mocha
  '';
  };

}
