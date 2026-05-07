#!/run/current-system/sw/bin/bash
# Hyprland Screenshot Script
# Save to ~/Pictures/screenshots/ + copy to clipboard + open in swappy
#
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 截图保存目录与文件名
SCREENSHOT_DIR="$HOME/Pictures/screenshots/"
SCREENSHOT_NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"
SCREENSHOT_PATH="$SCREENSHOT_DIR$SCREENSHOT_NAME"

# 确保目录存在
mkdir -p "$SCREENSHOT_DIR"

# 菜单选项
OPTIONS=(
    "Selected area"
    "Fullscreen (delay 3 sec)"
)

# Rofi 菜单选择
CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -replace -config "$HOME/.config/rofi/config-screenshot.rasi" -i -no-show-icons -l 2 -width 30 -p "Take Screenshot")

# 执行截图
case "$CHOICE" in
    "Selected area")
        grim -g "$(slurp)" "$SCREENSHOT_PATH"
        xclip -selection clipboard -t image/png -i "$SCREENSHOT_PATH"
        notify-send "Screenshot" "Saved & copied to clipboard\nMode: Selected area"
        swappy -f "$SCREENSHOT_PATH"
        ;;
    "Fullscreen (delay 3 sec)")
        sleep 3
        grim "$SCREENSHOT_PATH"
        xclip -selection clipboard -t image/png -i "$SCREENSHOT_PATH"
        notify-send "Screenshot" "Saved & copied to clipboard\nMode: Fullscreen"
        swappy -f "$SCREENSHOT_PATH"
        ;;
esac