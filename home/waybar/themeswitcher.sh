#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# theme switcher  Config
# Author: Silas Zhang (2026)
# ----------------------------------------------------- 
# --------------------------
# 基础配置
# --------------------------
THEMES_PATH="$HOME/.config/waybar/themes"
CACHE_FILE="$HOME/.cache/.themestyle.sh"
ROFI_CONFIG="$HOME/.config/rofi/config-themes.rasi"

# 初始化数�?
unset listThemes listNames listNames2
declare -a listThemes listNames listNames2

# --------------------------
# 扫描所有主�?
# --------------------------
sleep 0.2

# 遍历 themes �?~2级目�?
while IFS= read -r dir; do
    # 跳过根目�?& assets 目录
    [[ "$dir" == "$THEMES_PATH" ]] && continue
    [[ "$dir" == "$THEMES_PATH/assets" ]] && continue

    # 只取一级子目录（无更深目录�?
    subdir_count=$(find "$dir" -maxdepth 1 -type d | wc -l)
    [[ $subdir_count -ne 1 ]] && continue

    # 提取路径
    rel_path="${dir#$THEMES_PATH}"
    IFS='/' read -ra parts <<< "$rel_path"
    theme_id="/${parts[1]};$rel_path"

    # 读取主题名称
    if [[ -f "$dir/config.sh" ]]; then
        source "$dir/config.sh"
        name="$theme_name"
    else
        name="$theme_id"
    fi

    # 加入列表
    listThemes+=("$theme_id")
    listNames+=("$name")
    listNames2+=("$name")

done < <(find "$THEMES_PATH" -maxdepth 2 -type d)

# --------------------------
# �?rofi 选择主题
# --------------------------
choice=$(printf "%s\n" "${listNames[@]}" \
    | rofi -dmenu \
            -replace \
            -i \
            -config "$ROFI_CONFIG" \
            -no-show-icons \
            -width 30 \
            -p "Themes" \
            -format i)

# 没选择直接退�?
[[ -z $choice ]] && exit 0

# --------------------------
# 应用主题
# --------------------------
selected_theme="${listThemes[$choice]}"
selected_name="${listNames2[$choice]}"

echo "$selected_theme" > "$CACHE_FILE"

# 重启 waybar
"$HOME/.config/waybar/launch.sh"

notify-send "Waybar 主题已切�? "�?$selected_name"