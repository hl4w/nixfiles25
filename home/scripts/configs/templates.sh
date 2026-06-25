#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# template Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 模板目录
template_dir="$HOME/private/templates"

# 选择模板文件
selected=$(ls -1 "$template_dir" | rofi -dmenu -p "Select the template")

# 选中则复制文件内容到剪贴板
if [[ -n "$selected" ]]; then
    xclip -selection clipboard "$template_dir/$selected"
fi