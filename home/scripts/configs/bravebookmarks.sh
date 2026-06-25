#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# Brave Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 读取 Brave 书签，提取所有 url
bookmark_file="$HOME/.config/BraveSoftware/Brave-Browser/Default/Bookmarks"

# 筛选链接、去引号、通过 rofi 选择
selected=$(
  grep '"url":' "$bookmark_file" \
    | awk '{print $2}' \
    | sed 's/"//g' \
    | rofi -dmenu -p "Select Brave Bookmark"
)

# 选中则打开
if [[ -n $selected ]]; then
  brave "$selected"
fi