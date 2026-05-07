#!/run/current-system/sw/bin/bash
# NixOS Hyprland 安全重启脚本
# 强制终止并重启 Hyprland

# 等待确保进程释放
sleep 0.5

# 彻底杀死 Hyprland 进程
killall Hyprland

# 等待 2 秒确保完全退出
sleep 2