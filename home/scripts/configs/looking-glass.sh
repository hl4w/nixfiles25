#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# looking glass Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 获取虚拟机状?
VM_STATUS=$(virsh --connect qemu:///system list | grep " win11 " | awk '{print $3}')

# 如果未运行，则启?
if [[ -z "$VM_STATUS" || "$VM_STATUS" != "running" ]]; then
    virsh --connect qemu:///system start win11
    echo "Virtual Machine win11 is starting..."
    sleep 3
fi

# 启动 Looking Glass
looking-glass-client &
exit