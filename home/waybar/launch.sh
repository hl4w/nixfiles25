#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# Waybar lauch  Config
# Author: Silas Zhang (2026)
# ----------------------------------------------------- 

# 关闭所有已运行的 waybar 进程
pkill waybar
sleep 0.2

# 默认主题配置
DEFAULT_THEME="/hl4w;/hl4w/light"
THEME_STYLE="$DEFAULT_THEME"

# 从缓存读取当前主题
CACHE_FILE="$HOME/.cache/.themestyle.sh"
if [[ -f "$CACHE_FILE" ]]; then
    THEME_STYLE="$(cat "$CACHE_FILE")"
else
    echo "$DEFAULT_THEME" > "$CACHE_FILE"
fi

# 分割主题字符串
IFS=';' read -ra THEMES <<< "$THEME_STYLE"
THEME_BASE="${THEMES[0]}"
THEME_VARIANT="${THEMES[1]}"

# 主题无效则恢复默认
THEME_DIR="$HOME/.config/waybar/themes"
STYLE_PATH="${THEME_DIR}${THEME_VARIANT}/style.css"
if [[ ! -f "$STYLE_PATH" ]]; then
    THEME_BASE="/hl4w"
    THEME_VARIANT="/hl4w/light"
fi

echo "✅ 加载主题: $THEME_BASE"

# 优先使用自定义配置
CONFIG_FILE="config"
STYLE_FILE="style.css"

[[ -f "${THEME_DIR}${THEME_BASE}/config-custom" ]] && CONFIG_FILE="config-custom"
[[ -f "${THEME_DIR}${THEME_VARIANT}/style-custom.css" ]] && STYLE_FILE="style-custom.css"

# 启动 waybar
waybar \
    -c "${THEME_DIR}${THEME_BASE}/${CONFIG_FILE}" \
    -s "${THEME_DIR}${THEME_VARIANT}/${STYLE_FILE}" &