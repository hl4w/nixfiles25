#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# HL4W Launcher Script
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 菜单选项
OPTIONS=(
    "HL4W .config Settings"
    "Hyprland Settings"
    "Change Wallpaper"
    "Change Waybar Theme"
    "HL4W Welcome App"
)

# 用 rofi 显示选择菜单
CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -replace -config "$HOME/.config/rofi/config-hl4w-launcher.rasi" -l 5)

# 执行对应动作
case "$CHOICE" in
    "HL4W .config Settings")
        "$HOME/.config/hl4w-hyprland-settings/settings.sh"
        ;;
    "Hyprland Settings")
        "$HOME/.config/hl4w-hyprland-settings/hyprland-settings.sh"
        ;;
    "Change Wallpaper")
        "$HOME/.config/hypr/scripts/wallpaper.sh select"
        ;;
    "Change Waybar Theme")
        "$HOME/.config/waybar/themeswitcher.sh"
        ;;
    "HL4W Welcome App")
        "$HOME/.config/hypr/scripts/hl4w-welcome.sh"
        ;;
esac