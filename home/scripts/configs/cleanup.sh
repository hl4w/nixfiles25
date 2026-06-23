#!/usr/bin/env bash

# -----------------------------------------------------
# System cleanup script
# Author: Silas Zhang (2026)
# -----------------------------------------------------

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
info "  System Cleanup Script"
info "========================================"
info ""

info "1. Cleaning up temporary files..."
rm -rf ~/.cache/* ~/.tmp/* 2>/dev/null || true
success "Temporary files cleaned"

info "2. Cleaning up thumbnail cache..."
rm -rf ~/.thumbnails/* 2>/dev/null || true
success "Thumbnail cache cleaned"

info "3. Cleaning up old log files..."
find ~/.local/share -name "*.log" -type f -mtime +7 -delete 2>/dev/null || true
success "Old log files cleaned"

info "4. Cleaning up package manager cache..."
if command -v nix-collect-garbage &>/dev/null; then
    info "Running nix-collect-garbage..."
    sudo nix-collect-garbage -d
    success "Nix garbage collected"
else
    warning "nix-collect-garbage not available"
fi

info "5. Cleaning up flatpak cache..."
if command -v flatpak &>/dev/null; then
    info "Running flatpak cleanup..."
    flatpak uninstall --unused -y
    success "Flatpak cleaned"
else
    warning "flatpak not available"
fi

info ""
success "========================================"
success "  Cleanup completed successfully!"
success "========================================"