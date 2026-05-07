#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# Lauch VM Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

#  credential file path
cred_file="$HOME/private/win11-credentials.sh"

# load credentials or use fallback
if [[ -f "$cred_file" ]]; then
    echo "Credential file exists. Using the file."
    source "$cred_file"
else
    win11user="USER"
    win11pass="PASS"
    vmip="192.168.122.44"
fi

# get win11 vm state
vm_state="$(virsh --connect qemu:///system list | grep ' win11 ' | awk '{print $3}')"

# start vm if not running
if [[ -z "$vm_state" || "$vm_state" != "running" ]]; then
    echo "Virtual Machine win11 is starting now... Waiting 30s before starting xfreerdp."
    notify-send \
        "Virtual Machine win11 is starting now..." \
        "Waiting 30s before starting xfreerdp."

    virsh --connect qemu:///system start win11
    sleep 30
else
    notify-send \
        "Virtual Machine win11 is already running." \
        "Launching xfreerdp now!"
    echo "Starting xfreerdp now..."
fi

# launch xfreerdp in background
xfreerdp \
    -grab-keyboard \
    /v:"$vmip" \
    /size:100% \
    /cert-ignore \
    /u:"$win11user" \
    /p:"$win11pass" \
    /d: \
    /dynamic-resolution \
    /gfx-h264:avc444 \
    +gfx-progressive &