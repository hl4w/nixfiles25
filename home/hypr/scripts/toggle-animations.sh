#!/run/current-system/sw/bin/bash
# Hyprland Animation Toggle Script
# Author: Silas Zhang (2026)

set -euo pipefail

readonly CACHE_FILE="$HOME/.cache/toggle_animation"
readonly ANIMATION_CONF="$HOME/.config/hypr/conf/animation.conf"

if grep -q "disabled" "$ANIMATION_CONF"; then
    echo ":: Toggle blocked by disabled.conf variation."
else
    if [[ -f "$CACHE_FILE" ]]; then
        hyprctl keyword animations:enabled true
        rm -f "$CACHE_FILE"
    else
        hyprctl keyword animations:enabled false
        touch "$CACHE_FILE"
    fi
fi