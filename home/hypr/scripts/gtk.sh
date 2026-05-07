#!/run/current-system/sw/bin/bash
# GTK Settings Sync for Hyprland / NixOS
# 自动从 GTK3 配置同步主题、图标、光标、字体

# GTK 配置文件路径
GTK_CONFIG="$HOME/.config/gtk-3.0/settings.ini"
CURSOR_CONF="$HOME/.config/hypr/conf/cursor.conf"

# 检查配置文件是否存在
[ ! -f "$GTK_CONFIG" ] && exit 1

# 读取 GTK 设置
parse_gtk() {
    grep "$1" "$GTK_CONFIG" | sed 's/.*\s*=\s*//' | head -n1
}

GTK_THEME=$(parse_gtk "gtk-theme-name")
ICON_THEME=$(parse_gtk "gtk-icon-theme-name")
CURSOR_THEME=$(parse_gtk "gtk-cursor-theme-name")
CURSOR_SIZE=$(parse_gtk "gtk-cursor-theme-size")
FONT_NAME=$(parse_gtk "gtk-font-name")

# 输出调试信息
echo "GTK Theme: $GTK_THEME"
echo "Icon Theme: $ICON_THEME"
echo "Cursor Theme: $CURSOR_THEME"
echo "Cursor Size: $CURSOR_SIZE"
echo "Font: $FONT_NAME"

# 同步到 gsettings
SCHEMA="org.gnome.desktop.interface"
gsettings set "$SCHEMA" gtk-theme "$GTK_THEME"
gsettings set "$SCHEMA" icon-theme "$ICON_THEME"
gsettings set "$SCHEMA" cursor-theme "$CURSOR_THEME"
gsettings set "$SCHEMA" font-name "$FONT_NAME"
gsettings set "$SCHEMA" color-scheme "prefer-dark"

# 同步光标主题到 Hyprland
if [ -f "$CURSOR_CONF" ]; then
    echo "exec-once = hyprctl setcursor $CURSOR_THEME $CURSOR_SIZE" > "$CURSOR_CONF"
    hyprctl setcursor "$CURSOR_THEME" "$CURSOR_SIZE"
fi