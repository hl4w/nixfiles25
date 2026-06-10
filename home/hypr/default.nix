{ pkgs, config, lib, ... }:

{
  home.activation.installHypr = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/hypr
    cp -rf ${../hypr}/hypridle.conf $HOME/.config/hypr/
    cp -rf ${../hypr}/hyprland.conf $HOME/.config/hypr/
    cp -rf ${../hypr}/hyprlock.conf $HOME/.config/hypr/
    cp -rf ${../hypr}/hyprpaper.conf $HOME/.config/hypr/
    find $HOME/.config/hypr -type f -name "*.conf" -exec chmod 644 {} \;

    mkdir -p $HOME/.config/hypr/conf
    cp -rf ${../hypr}/conf/* $HOME/.config/hypr/conf/
    find $HOME/.config/hypr/conf -type d -exec chmod 755 {} \;
    find $HOME/.config/hypr/conf -type f -name "*.conf" -exec chmod 644 {} \;

    mkdir -p $HOME/.config/hypr/noctalia
    cp -rf ${../hypr}/noctalia/noctalia-colors.conf $HOME/.config/hypr/noctalia/noctalia-colors.conf
    chmod 644 $HOME/.config/hypr/noctalia/noctalia-colors.conf

    mkdir -p $HOME/.config/hypr/scripts
    cp -rf ${../hypr}/scripts/* $HOME/.config/hypr/scripts/
    find $HOME/.config/hypr/scripts -type f -name "*.sh" -exec chmod 755 {} \;
    chmod 755 $HOME/.config/hypr/scripts/active-monitor.py
  '';
}