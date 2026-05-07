#!/run/current-system/sw/bin/bash
cat <<"EOF"
 _____ _       _      _   
|  ___(_) __ _| | ___| |_ 
| |_  | |/ _` | |/ _ \ __|
|  _| | | (_| | |  __/ |_ 
|_|   |_|\__, |_|\___|\__|
         |___/            

EOF

# -----------------------------------------------------
# Script to create ascii font based header on user input
# and copy the result to the clipboard
# -----------------------------------------------------

# 定义路径
output_file="$HOME/figlet.txt"

# 获取用户输入
read -p "Enter the text for ascii encoding: " mytext

# 确保文件存在
touch "$output_file"

# 一次性写入模板内容
{
    echo 'cat <<"EOF"'
    figlet "$mytext"
    echo
    echo "EOF"
} > "$output_file"

# 读取内容并复制到剪贴板
content=$(cat "$output_file")
wl-copy "$content"
xclip -selection clipboard "$output_file"

echo "Text copied to clipboard!"