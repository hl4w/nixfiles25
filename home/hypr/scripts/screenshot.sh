#!/run/current-system/sw/bin/bash
# Hyprland Screenshot Script
# Save to ~/Pictures/screenshots/ + copy to clipboard + open in swappy
# Author: Silas Zhang (2026)

set -euo pipefail

readonly SCREENSHOT_DIR="$HOME/Pictures/screenshots/"
readonly SCREENSHOT_NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"
readonly SCREENSHOT_PATH="$SCREENSHOT_DIR$SCREENSHOT_NAME"

mkdir -p "$SCREENSHOT_DIR"

OPTIONS=(
    "Selected area"
    "Fullscreen (delay 3 sec)"
)

CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -replace \
    -config "$HOME/.config/rofi/config-screenshot.rasi" \
    -i -no-show-icons -l 2 -width 30 -p "Take Screenshot")

case "$CHOICE" in
    "Selected area")
        grim -g "$(slurp)" "$SCREENSHOT_PATH"
        wl-copy < "$SCREENSHOT_PATH"
        notify-send "Screenshot" "Saved & copied to clipboard\nMode: Selected area"
        swappy -f "$SCREENSHOT_PATH" &
        ;;
    "Fullscreen (delay 3 sec)")
        sleep 3
        grim "$SCREENSHOT_PATH"
        wl-copy < "$SCREENSHOT_PATH"
        notify-send "Screenshot" "Saved & copied to clipboard\nMode: Fullscreen"
        swappy -f "$SCREENSHOT_PATH" &
        ;;
esac