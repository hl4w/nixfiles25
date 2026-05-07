#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# cliphist Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 配置路径
ROFI_CLIP="$HOME/.config/rofi/config-cliphist.rasi"
ROFI_SHORT="$HOME/.config/rofi/config-short.rasi"

case "$1" in
    d)
        cliphist list | rofi -dmenu -replace -config "$ROFI_CLIP" | cliphist delete
        ;;

    w)
        choice=$(echo -e "Clear\nCancel" | rofi -dmenu -config "$ROFI_SHORT")
        if [[ "$choice" == "Clear" ]]; then
            cliphist wipe
        fi
        ;;

    *)
        cliphist list | rofi -dmenu -replace -config "$ROFI_CLIP" | cliphist decode | wl-copy
        ;;
esac