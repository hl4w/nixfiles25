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
info "  HL4W - NixOS 25.11 Auto Installation"
info "========================================"
info ""

read -p "Enter username (default: hl4w): " USERNAME
USERNAME="${USERNAME:-hl4w}"

read -p "Enter hostname (default: nixos): " HOSTNAME
HOSTNAME="${HOSTNAME:-nixos}"

read -p "Enter Git user name (default: $USERNAME): " GIT_NAME
GIT_NAME="${GIT_NAME:-$USERNAME}"

read -p "Enter Git user email (default: $USERNAME@localhost): " GIT_EMAIL
GIT_EMAIL="${GIT_EMAIL:-$USERNAME@localhost}"

info ""
info "Your configuration:"
info "  - Username: $USERNAME"
info "  - Hostname: $HOSTNAME"
info "  - Git Name: $GIT_NAME"
info "  - Git Email: $GIT_EMAIL"
info ""

read -p "Confirm the above information? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    info "Installation cancelled"
    exit 0
fi

info ""
info "Modifying configuration files..."

if [[ ! -f "flake.nix" ]]; then
    error "flake.nix file not found"
    exit 1
fi

sed -i "s/username = \"[^\"]*\"/username = \"$USERNAME\"/g" flake.nix
sed -i "s/hostname = \"[^\"]*\"/hostname = \"$HOSTNAME\"/g" flake.nix
success "flake.nix updated"

if [[ ! -f "users/home.nix" ]]; then
    error "users/home.nix file not found"
    exit 1
fi

sed -i "s/user\.name = \"[^\"]*\"/user.name = \"$GIT_NAME\"/g" users/home.nix
sed -i "s/user\.email = \"[^\"]*\"/user.email = \"$GIT_EMAIL\"/g" users/home.nix
success "users/home.nix updated"

info ""
info "Generating flake.lock..."
nix flake update --commit-lock-file || warning "flake.lock update failed, continuing deployment"

info ""
info "Deploying system configuration..."
info "This may take some time, please wait..."

if sudo nixos-rebuild switch --flake .#"$HOSTNAME"; then
    success ""
    success "========================================"
    success "  System deployed successfully!"
    success "========================================"
    success ""
    success "Hostname: $HOSTNAME"
    success "Username: $USERNAME"
    success ""
    success "Please log out and log back in to apply all changes"
else
    error "System deployment failed"
    exit 1
fi