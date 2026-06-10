#!/run/current-system/sw/bin/bash
# Hyprland Wallpaper Script
# Author: Silas Zhang (2026)

set -euo pipefail

readonly CACHE_DIR="$HOME/.cache"
readonly WALLPAPER_DIR="$HOME/wallpaper"
readonly CONFIG_DIR="$HOME/.config"
readonly SETTINGS_DIR="$CONFIG_DIR/settings"

readonly CACHE_FILE="$CACHE_DIR/current_wallpaper"
readonly BLURRED_WALLPAPER="$CACHE_DIR/blurred_wallpaper.png"
readonly SQUARE_WALLPAPER="$CACHE_DIR/square_wallpaper.png"
readonly RASI_FILE="$CACHE_DIR/current_wallpaper.rasi"
readonly BLUR_FILE="$SETTINGS_DIR/blur.sh"

readonly DEFAULT_WALLPAPER="$WALLPAPER_DIR/default.png"
readonly DEFAULT_BLUR="50x30"
readonly TRANSITION_TYPE="wipe"

mkdir -p "$CACHE_DIR" "$WALLPAPER_DIR" "$SETTINGS_DIR"

blur_str="$DEFAULT_BLUR"
[[ -f "$BLUR_FILE" ]] && blur_str=$(<"$BLUR_FILE")

if [[ ! -f "$CACHE_FILE" ]]; then
    echo "$DEFAULT_WALLPAPER" > "$CACHE_FILE"
fi

if [[ ! -f "$RASI_FILE" ]]; then
    echo "* { current-image: url(\"$DEFAULT_WALLPAPER\", height); }" > "$RASI_FILE"
fi

current_wallpaper=$(<"$CACHE_FILE")
mode="${1:-}"

case "$mode" in
    "init")
        sleep 1
        if [[ -f "$current_wallpaper" ]]; then
            wal -q -i "$current_wallpaper"
        else
            wal -q -i "$WALLPAPER_DIR"
        fi
        ;;
    "select")
        sleep 0.2
        selected=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
            | sort -R | while read -r file; do
                basename="${file##*/}"
                printf "%s\x00icon\x1f%s\n" "$basename" "$WALLPAPER_DIR/$basename"
            done | rofi -dmenu -i -replace -config "$CONFIG_DIR/rofi/config-wallpaper.rasi")

        [[ -z "$selected" ]] && { echo "No wallpaper selected"; exit 0; }
        wal -q -i "$WALLPAPER_DIR/$selected"
        ;;
    *)
        wal -q -i "$WALLPAPER_DIR"
        ;;
esac

wallpaper="$current_wallpaper"
[[ -f "$CACHE_DIR/wal/colors.sh" ]] && source "$CACHE_DIR/wal/colors.sh"

echo ":: Wallpaper: $wallpaper"
newwall=$(basename "$wallpaper")

[[ -x "$CONFIG_DIR/waybar/launch.sh" ]] && "$CONFIG_DIR/waybar/launch.sh"

wallpaper_engine="swww"
[[ -f "$SETTINGS_DIR/wallpaper-engine.sh" ]] && wallpaper_engine=$(<"$SETTINGS_DIR/wallpaper-engine.sh")

if [[ "$wallpaper_engine" == "swww" ]]; then
    echo ":: Using swww"
    swww img "$wallpaper" \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps 60 \
        --transition-type "$TRANSITION_TYPE" \
        --transition-duration 0.7 \
        --transition-pos "$(hyprctl cursorpos 2>/dev/null)"
elif [[ "$wallpaper_engine" == "hyprpaper" ]]; then
    echo ":: Using hyprpaper"
    killall -q hyprpaper || true
    if [[ -f "$SETTINGS_DIR/hyprpaper.tpl" ]]; then
        wal_tpl=$(<"$SETTINGS_DIR/hyprpaper.tpl")
        echo "${wal_tpl//WALLPAPER/$wallpaper}" > "$CONFIG_DIR/hypr/hyprpaper.conf"
        hyprpaper & disown
    fi
fi

if [[ "$mode" != "init" ]]; then
    dunstify "Creating blurred version ..." "with image $newwall" \
        -h int:value:50 -h string:x-dunst-stack-tag:wallpaper
fi

magick "$wallpaper" -resize 75% "$BLURRED_WALLPAPER"
echo ":: Resized to 75%"

if [[ "$blur_str" != "0x0" ]]; then
    magick "$BLURRED_WALLPAPER" -blur "$blur_str" "$BLURRED_WALLPAPER"
    echo ":: Blurred"
fi

if [[ "$mode" != "init" ]]; then
    dunstify "Creating square version ..." "with image $newwall" \
        -h int:value:75 -h string:x-dunst-stack-tag:wallpaper
fi

magick "$wallpaper" -gravity Center -extent 1:1 "$SQUARE_WALLPAPER"
echo ":: Square version created"

echo "$wallpaper" > "$CACHE_FILE"
printf '* { current-image: url("%s", height); }\n' "$BLURRED_WALLPAPER" > "$RASI_FILE"

if [[ "$mode" != "init" ]]; then
    dunstify "Wallpaper procedure complete!" "with image $newwall" \
        -h int:value:100 -h string:x-dunst-stack-tag:wallpaper
fi

echo "DONE!"