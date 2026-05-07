# -----------------------------------------------------
# bash config file
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 非交互式终端直接退出
[[ $- != *i* ]] && return

# 默认提示符（被 starship 覆盖）
PS1='[\u@\h \W]\$ '

# 默认编辑器
export EDITOR=nvim

# =====================================================
# 系统别名
# =====================================================
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias ts='$HOME/.config/scripts/snapshot.sh'
alias wifi='nmtui'
alias rw='$HOME/.config/waybar/reload.sh'
alias dot='cd $HOME/.config'
alias cleanup='$HOME/.config/scripts/cleanup.sh'

# =====================================================
# Git 快捷命令
# =====================================================
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gst='git stash'
alias gsp='git stash; git pull'
alias gcheck='git checkout'
alias gcredential='git config credential.helper store'

# =====================================================
# 自定义脚本
# =====================================================
alias gr='python $HOME/.config/scripts/growthrate.py'
alias ascii='$HOME/.config/scripts/figlet.sh'

# =====================================================
# 虚拟机相关
# =====================================================
alias vm='$HOME/private/launchvm.sh'
alias lg='$HOME/.config/scripts/looking-glass.sh'

# =====================================================
# 配置文件快捷编辑
# =====================================================
alias confb='$EDITOR $HOME/.bashrc'
alias notes='$EDITOR $HOME/notes.txt'

# =====================================================
# Go 模块代理（国内加速）
# =====================================================
go env -w GOPROXY=https://goproxy.cn,direct

# =====================================================
# Starship 提示符
# =====================================================
eval "$(starship init bash)"

# =====================================================
# Pywal 颜色加载
# =====================================================
[ -f $HOME/.cache/wal/sequences ] && cat $HOME/.cache/wal/sequences

# =====================================================
# 终端启动自动运行 fastfetch
# =====================================================
echo ""
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
else
    command -v hyprctl >/dev/null 2>&1 && echo "Start Hyprland with command: Hyprland"
fi