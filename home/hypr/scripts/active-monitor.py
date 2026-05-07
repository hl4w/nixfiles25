import sys
import subprocess
import os
import json

# 获取当前脚本路径
pathname = os.path.dirname(sys.argv[0])

# 使用 $HOME 环境变量
home_folder = os.environ["HOME"]
dotfiles_folder = os.path.join(home_folder, ".config")

# 执行监视器检测脚本
script_path = os.path.join(dotfiles_folder, "hypr", "scripts", "monitors.sh")
result = subprocess.run(
    ["bash", script_path],
    capture_output=True,
    text=True
)

# 解析 JSON 输出
monitors_json = result.stdout.strip()
monitors = json.loads(monitors_json)

# 输出当前聚焦的显示器 ID
for monitor in monitors:
    if monitor.get("focused", False):
        print(monitor["id"])