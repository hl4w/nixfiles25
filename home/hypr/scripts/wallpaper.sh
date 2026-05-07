#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# Dunst Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# ==========================
# 基础路径配置
# ==========================
readonly CACHE_DIR="$HOME/.cache"
readonly WALLPAPER_DIR="$HOME/wallpaper"
readonly CONFIG_DIR="$HOME/.config"
readonly SETTINGS_DIR="$CONFIG_DIR/settings"

# 缓存文件
readonly CACHE_FILE="$CACHE_DIR/current_wallpaper"
readonly BLURRED_WALLPAPER="$CACHE_DIR/blurred_wallpaper.png"
readonly SQUARE_WALLPAPER="$CACHE_DIR/square_wallpaper.png"
readonly RASI_FILE="$CACHE_DIR/current_wallpaper.rasi"
readonly BLUR_FILE="$SETTINGS_DIR/blur.sh"

# 默认配置
readonly DEFAULT_WALLPAPER="$WALLPAPER_DIR/default.png"
readonly DEFAULT_BLUR="50x30"
readonly TRANSITION_TYPE="wipe"

# ==========================
# 自动创建目录
# ==========================
mkdir -p "$CACHE_DIR" "$WALLPAPER_DIR" "$SETTINGS_DIR"

# ==========================
# 读取模糊参数
# ==========================
blur_str="$DEFAULT_BLUR"
[[ -f "$BLUR_FILE" ]] && blur_str=$(<"$BLUR_FILE")

# ==========================
# 初始化缓存文件
# ==========================
if [[ ! -f "$CACHE_FILE" ]]; then
    echo "$DEFAULT_WALLPAPER" > "$CACHE_FILE"
fi

if [[ ! -f "$RASI_FILE" ]]; then
    echo "* { current-image: url(\"$DEFAULT_WALLPAPER\", height); }" > "$RASI_FILE"
fi

current_wallpaper=$(<"$CACHE_FILE")

# ==========================
# 处理运行模式
# ==========================
mode="$1"
case "$mode" in
    "init")
        sleep 1
        [[ -f "$current_wallpaper" ]] && wal -q -i "$current_wallpaper" || wal -q -i "$WALLPAPER_DIR"
        ;;

    "select")
        sleep 0.2
        selected=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
            | sort -R | while read -r file; do
                basename="${file##*/}"
                echo -en "$basename\x00icon\x1f$WALLPAPER_DIR/$basename\n"
            done | rofi -dmenu -i -replace -config "$CONFIG_DIR/rofi/config-wallpaper.rasi")

        [[ -z "$selected" ]] && { echo "No wallpaper selected"; exit 1; }
        wal -q -i "$WALLPAPER_DIR/$selected"
        ;;

    *)
        wal -q -i "$WALLPAPER_DIR"
        ;;
esac

# ==========================
# 加载 pywal 颜色
# ==========================
wallpaper="$current_wallpaper"
[[ -f "$CACHE_DIR/wal/colors.sh" ]] && source "$CACHE_DIR/wal/colors.sh"

echo ":: Wallpaper: $wallpaper"
newwall=$(basename "$wallpaper")

# ==========================
# 重启 Waybar
# ==========================
[[ -x "$CONFIG_DIR/waybar/launch.sh" ]] && "$CONFIG_DIR/waybar/launch.sh"

# ==========================
# 壁纸引擎切换 (swww / hyprpaper)
# ==========================
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
    killall -q hyprpaper
    if [[ -f "$SETTINGS_DIR/hyprpaper.tpl" ]]; then
        wal_tpl=$(<"$SETTINGS_DIR/hyprpaper.tpl")
        echo "${wal_tpl//WALLPAPER/$wallpaper}" > "$CONFIG_DIR/hypr/hyprpaper.conf"
        hyprpaper & disown
    fi
fi

# ==========================
# 生成模糊壁纸
# ==========================
[[ "$mode" != "init" ]] && \
    dunstify "Creating blurred version ..." "with image $newwall" \
    -h int:value:50 -h string:x-dunst-stack-tag:wallpaper

magick "$wallpaper" -resize 75% "$BLURRED_WALLPAPER"
echo ":: Resized to 75%"

[[ "$blur_str" != "0x0" ]] && {
    magick "$BLURRED_WALLPAPER" -blur "$blur_str" "$BLURRED_WALLPAPER"
    echo ":: Blurred"
}

# ==========================
# 生成方形壁纸
# ==========================
[[ "$mode" != "init" ]] && \
    dunstify "Creating square version ..." "with image $newwall" \
    -h int:value:75 -h string:x-dunst-stack-tag:wallpaper

magick "$wallpaper" -gravity Center -extent 1:1 "$SQUARE_WALLPAPER"
echo ":: Square version created"

# ==========================
# 写入缓存
# ==========================
echo "$wallpaper" > "$CACHE_FILE"
echo "* { current-image: url(\"$BLURRED_WALLPAPER\", height); }" > "$RASI_FILE"

# ==========================
# 完成通知
# ==========================
[[ "$mode" != "init" ]] && \
    dunstify "Wallpaper procedure complete!" "with image $newwall" \
    -h int:value:100 -h string:x-dunst-stack-tag:wallpaper

echo "DONE!"