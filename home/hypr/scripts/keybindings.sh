#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# NixOS / Hyprland
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 配置文件路径
KEYBIND_CONF="$HOME/.config/hypr/conf/keybinding.conf"
ROFI_CONFIG="$HOME/.config/rofi/config-compact.rasi"

# 读取真实快捷键配置路径
config_file=$(cat "$KEYBIND_CONF")
config_file=${config_file/source = ~/}
config_file=${config_file/source=~/}
config_file="$HOME$config_file"

echo "Reading from: $config_file"

# 解析 Hyprland 绑定键
keybinds=$(grep -oP '(?<=bind = ).*' "$config_file")
keybinds=$(
    echo "$keybinds" |
    sed 's/$mainMod/SUPER/g' |
    sed 's/,\([^,]*\)$/ = \1/' |
    sed 's/, exec//g' |
    sed 's/^,//g'
)

# 用 rofi 展示快捷键
sleep 0.2
rofi -dmenu -i -replace -p "Keybinds" -config "$ROFI_CONFIG" <<< "$keybinds"