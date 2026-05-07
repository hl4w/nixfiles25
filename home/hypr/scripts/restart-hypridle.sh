#!/run/current-system/sw/bin/bash
# 重启 hypridle 服务

# 终止原有进程
killall hypridle

# 短暂等待后后台启动
sleep 1
hypridle &

# 发送通知
notify-send "hypridle" "已成功重启"