#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# Dunst Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# XDG Desktop Portal 守护进程管理
# 用于修复 Hyprland 截图、屏幕共享、文件选择器

# 等待系统稳定
sleep 1

# 强制关闭所有 XDG 桌面门户进程
echo ":: Stopping all XDG Desktop Portal processes..."
pkill  xdg-desktop-portal-hyprland
pkill  xdg-desktop-portal-gnome
pkill  xdg-desktop-portal-kde
pkill  xdg-desktop-portal-lxqt
pkill  xdg-desktop-portal-wlr
pkill  xdg-desktop-portal-gtk
pkill  xdg-desktop-portal
sleep 1

# 启动 Hyprland 专用门户
echo ":: Starting xdg-desktop-portal-hyprland..."
xdg-desktop-portal-hyprland & 
sleep 2

# 启动通用 XDG 门户
echo ":: Starting xdg-desktop-portal..."
xdg-desktop-portal & 
sleep 1

echo ":: XDG Portal restart completed!"