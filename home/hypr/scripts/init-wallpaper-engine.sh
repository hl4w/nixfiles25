#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# Dunst Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 壁纸引擎自动启动脚本 | NixOS + Hyprland
CONFIG_FILE="$HOME/.config/settings/wallpaper-engine.sh"
WALLPAPER_SCRIPT="$HOME/.config/hypr/scripts/wallpaper.sh"

# 读取壁纸引擎设置
wallpaper_engine=$(cat "$CONFIG_FILE")

# 根据选择启动对应引擎
case "$wallpaper_engine" in
    "swww")
        echo ":: Using swww"
        swww init
        swww-daemon --format xrgb
        sleep 0.5
        ;;
    "hyprpaper")
        echo ":: Using hyprpaper"
        sleep 0.5
        ;;
    *)
        echo ":: Wallpaper Engine disabled"
        ;;
esac

# 统一执行壁纸初始化
"$WALLPAPER_SCRIPT" init