# -----------------------------------------------------
# bash config file
# Author: Silas Zhang (2026)
# -----------------------------------------------------

[[ $- != *i* ]] && return

# =====================================================
# 基础配置
# =====================================================
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-R --incsearch --ignore-case --status-column'

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT='%F %T '

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd
shopt -s cdspell

# =====================================================
# 路径配置
# =====================================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"
export PATH="$HOME/go/bin:$PATH"

# =====================================================
# 系统别名
# =====================================================
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'

if command -v eza &>/dev/null; then
    alias ls='eza -a --icons'
    alias ll='eza -al --icons'
    alias lt='eza -a --tree --level=1 --icons'
    alias llt='eza -al --tree --level=2 --icons'
else
    alias ls='ls -aF --color=auto'
    alias ll='ls -alF --color=auto'
fi

alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'
alias lock='hyprlock'

alias v='$EDITOR'
alias vim='$EDITOR'
alias vi='$EDITOR'

alias wifi='nmtui'
alias dot='cd $HOME/.config'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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
alias gl='git log --oneline --graph --decorate -10'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# =====================================================
# 系统管理
# =====================================================
alias cleanup='$HOME/.config/scripts/cleanup.sh'
alias update='sudo nixos-rebuild switch --flake .#'
alias nix-update='sudo nix-channel --update && sudo nixos-rebuild switch'
alias nix-collect='sudo nix-collect-garbage -d'

# =====================================================
# 自定义脚本
# =====================================================
alias ts='$HOME/.config/scripts/snapshot.sh'
alias ascii='$HOME/.config/scripts/figlet.sh'

# =====================================================
# 虚拟机相关
# =====================================================
[ -f "$HOME/private/launchvm.sh" ] && alias vm='$HOME/private/launchvm.sh'
[ -f "$HOME/.config/scripts/looking-glass.sh" ] && alias lg='$HOME/.config/scripts/looking-glass.sh'

# =====================================================
# 配置文件快捷编辑
# =====================================================
alias confb='$EDITOR $HOME/.bashrc'
alias confh='$EDITOR $HOME/.config/hypr/hyprland.conf'
alias confw='$EDITOR $HOME/.config/waybar/config.jsonc'
alias notes='$EDITOR $HOME/notes.txt'

# =====================================================
# Go 模块代理（国内加速）
# =====================================================
if command -v go &>/dev/null; then
    export GOPROXY=https://goproxy.cn,direct
    export GOPRIVATE=git.hl4w.com
fi

# =====================================================
# Starship 提示符
# =====================================================
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    PS1='[\u@\h \W]\$ '
fi

# =====================================================
# Pywal 颜色加载
# =====================================================
[ -f "$HOME/.cache/wal/sequences" ] && cat "$HOME/.cache/wal/sequences"

# =====================================================
# Waybar 重载
# =====================================================
alias rw='$HOME/.config/waybar/reload.sh'

# =====================================================
# 终端启动自动运行 fastfetch
# =====================================================
echo ""
if [[ $(tty) == *"pts"* ]]; then
    if command -v fastfetch &>/dev/null; then
        fastfetch
    elif command -v neofetch &>/dev/null; then
        neofetch
    fi
else
    command -v hyprctl >/dev/null 2>&1 && echo "Start Hyprland with command: Hyprland"
fi