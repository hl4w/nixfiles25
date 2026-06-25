#!/run/current-system/sw/bin/bash

# -----------------------------------------------------
# nm applet Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

if [[ "$1" == "stop" ]]; then
    # 终止 plasma-nm 进程
    killall plasma-nm
else
    # 后台启动托盘指示?
    plasma-nm --indicator &
fi