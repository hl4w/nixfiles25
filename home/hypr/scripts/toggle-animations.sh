#!/run/current-system/sw/bin/bash
# Hyprland 动画开关切换脚本

CACHE_FILE="$HOME/.cache/toggle_animation"
ANIMATION_CONF="$HOME/.config/hypr/conf/animation.conf"

# 检查是否被全局禁用
if grep -q "disabled" "$ANIMATION_CONF"; then
    echo ":: Toggle blocked by disabled.conf variation."
else
    # 切换动画状态
    if [ -f "$CACHE_FILE" ]; then
        hyprctl keyword animations:enabled true
        rm -f "$CACHE_FILE"
    else
        hyprctl keyword animations:enabled false
        touch "$CACHE_FILE"
    fi
fi