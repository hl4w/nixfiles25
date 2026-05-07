import sys
import subprocess
import os
import json
import pathlib
import shutil

# 安全获取 HOME 目录
home = os.environ["HOME"]
dotfiles = os.path.join(home, ".config")

# 执行监视器脚本并获取 JSON 输出
script_path = os.path.join(dotfiles, "hypr", "scripts", "monitors.sh")
result = subprocess.run(
    ["bash", script_path],
    capture_output=True,
    text=True
)

monitors_json = result.stdout.strip()
monitors_arr = json.loads(monitors_json)

# 输出当前聚焦的显示器 ID
for monitor in monitors_arr:
    if monitor["focused"]:
        print(monitor["id"])