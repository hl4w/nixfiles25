#!/usr/bin/env bash

# -----------------------------------------------------
# Waybar reload script
# Author: Silas Zhang (2026)
# -----------------------------------------------------

killall -SIGUSR2 waybar || pkill -USR2 waybar