#!/usr/bin/env bash

# -----------------------------------------------------
# System snapshot script
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
info "  System Snapshot Script"
info "========================================"
info ""

SNAPSHOT_DIR="$HOME/.config/snapshots"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SNAPSHOT_FILE="$SNAPSHOT_DIR/snapshot-$TIMESTAMP.tar.gz"

info "Creating snapshot directory..."
mkdir -p "$SNAPSHOT_DIR"

info "Creating system configuration snapshot..."

tar -czvf "$SNAPSHOT_FILE" \
    --exclude=".git" \
    --exclude="node_modules" \
    --exclude="__pycache__" \
    --exclude="*.pyc" \
    ~/.config/hypr \
    ~/.config/waybar \
    ~/.config/rofi \
    ~/.config/dunst \
    ~/.config/nvim \
    ~/.bashrc 2>/dev/null || true

if [ -f "$SNAPSHOT_FILE" ]; then
    SIZE=$(du -h "$SNAPSHOT_FILE" | cut -f1)
    success "Snapshot created: $SNAPSHOT_FILE"
    success "Size: $SIZE"
else
    error "Failed to create snapshot"
    exit 1
fi

info ""
info "To restore snapshot:"
info "  tar -xzvf $SNAPSHOT_FILE -C ~/"
info ""

success "========================================"
success "  Snapshot completed successfully!"
success "========================================"