#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

info "========================================"
info "  HL4W - NixOS 25.11 自动安装部署脚本"
info "========================================"
info ""

read -p "请输入用户名 (默认: hl4w): " USERNAME
USERNAME="${USERNAME:-hl4w}"

read -p "请输入主机名 (默认: nixos): " HOSTNAME
HOSTNAME="${HOSTNAME:-nixos}"

read -p "请输入 Git 用户姓名 (默认: $USERNAME): " GIT_NAME
GIT_NAME="${GIT_NAME:-$USERNAME}"

read -p "请输入 Git 用户邮箱 (默认: $USERNAME@localhost): " GIT_EMAIL
GIT_EMAIL="${GIT_EMAIL:-$USERNAME@localhost}"

info ""
info "您的配置信息："
info "  - 用户名: $USERNAME"
info "  - 主机名: $HOSTNAME"
info "  - Git 姓名: $GIT_NAME"
info "  - Git 邮箱: $GIT_EMAIL"
info ""

read -p "确认以上信息是否正确？(y/n): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    info "安装已取消"
    exit 0
fi

info ""
info "正在修改配置文件..."

if [[ ! -f "flake.nix" ]]; then
    error "flake.nix 文件不存在"
    exit 1
fi

sed -i "s/username = \"[^\"]*\"/username = \"$USERNAME\"/g" flake.nix
sed -i "s/hostname = \"[^\"]*\"/hostname = \"$HOSTNAME\"/g" flake.nix
success "flake.nix 已更新"

if [[ ! -f "users/home.nix" ]]; then
    error "users/home.nix 文件不存在"
    exit 1
fi

sed -i "s/user.name = \"[^\"]*\"/user.name = \"$GIT_NAME\"/g" users/home.nix
sed -i "s/user.email = \"[^\"]*\"/user.email = \"$GIT_EMAIL\"/g" users/home.nix
success "users/home.nix 已更新"

info ""
info "正在生成 flake.lock..."
nix flake update --commit-lock-file || warning "flake.lock 更新失败，继续尝试部署"

info ""
info "正在部署系统配置..."
info "这可能需要一些时间，请耐心等待..."

if sudo nixos-rebuild switch --flake .#"$HOSTNAME"; then
    success ""
    success "========================================"
    success "  系统部署成功！"
    success "========================================"
    success ""
    success "主机名: $HOSTNAME"
    success "用户名: $USERNAME"
    success ""
    success "请重新登录以应用所有更改"
else
    error "系统部署失败"
    exit 1
fi