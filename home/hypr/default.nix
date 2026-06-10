# =============================================================================
# Hyprland 配置安装模块
# =============================================================================
# 此模块负责将 Hyprland 的配置文件从 Nix 存储复制到用户主目录
# =============================================================================

{ pkgs, config, lib, ... }:

{
  # ============================================================================
  # Hyprland 配置安装
  # ============================================================================
  # 使用 Home Manager 的激活钩子在环境构建时复制配置文件
  home.activation.installHypr = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # --------------------------------------------------------------------------
    # 基础配置文件
    # --------------------------------------------------------------------------
    # 创建 Hyprland 配置目录
    mkdir -p $HOME/.config/hypr

    # 复制主配置文件
    cp -rf ${../hypr}/hypridle.conf $HOME/.config/hypr/
    cp -rf ${../hypr}/hyprland.conf $HOME/.config/hypr/
    cp -rf ${../hypr}/hyprlock.conf $HOME/.config/hypr/
    cp -rf ${../hypr}/hyprpaper.conf $HOME/.config/hypr/

    # 设置配置文件权限（644 = rw-r--r--）
    find $HOME/.config/hypr -type f -name "*.conf" -exec chmod 644 {} \;

    # --------------------------------------------------------------------------
    # 子配置文件
    # --------------------------------------------------------------------------
    # conf/ 目录包含各种分类配置
    mkdir -p $HOME/.config/hypr/conf
    cp -rf ${../hypr}/conf/* $HOME/.config/hypr/conf/

    # 目录权限（755 = rwxr-xr-x）
    find $HOME/.config/hypr/conf -type d -exec chmod 755 {} \;
    # 文件权限（644 = rw-r--r--）
    find $HOME/.config/hypr/conf -type f -name "*.conf" -exec chmod 644 {} \;

    # --------------------------------------------------------------------------
    # 主题配色
    # --------------------------------------------------------------------------
    # noctalia/ 目录包含 Noctalia 主题配色
    mkdir -p $HOME/.config/hypr/noctalia
    cp -rf ${../hypr}/noctalia/noctalia-colors.conf $HOME/.config/hypr/noctalia/noctalia-colors.conf
    chmod 644 $HOME/.config/hypr/noctalia/noctalia-colors.conf

    # --------------------------------------------------------------------------
    # 脚本文件
    # --------------------------------------------------------------------------
    # 复制 Hyprland 脚本并设置执行权限
    mkdir -p $HOME/.config/hypr/scripts
    cp -rf ${../hypr}/scripts/* $HOME/.config/hypr/scripts/

    # Shell 脚本执行权限（755 = rwxr-xr-x）
    find $HOME/.config/hypr/scripts -type f -name "*.sh" -exec chmod 755 {} \;

    # Python 脚本执行权限
    chmod 755 $HOME/.config/hypr/scripts/active-monitor.py
  '';

  # ============================================================================
  # 配置文件说明
  # ============================================================================
  # hypridle.conf    - Hyprland 空闲检测配置（自动锁定、超时等）
  # hyprland.conf    - Hyprland 主配置文件（窗口规则、快捷键等）
  # hyprlock.conf    - Hyprland 屏幕锁定配置
  # hyprpaper.conf   - Hyprland 壁纸配置
  #
  # conf/ 子目录：
  #   animations/    - 动画效果配置
  #   decorations/   - 窗口装饰配置
  #   environments/  - 环境变量配置
  #   keybindings/   - 键盘快捷键配置
  #   monitors/      - 显示器配置
  #   windowrules/   - 窗口规则配置
  #   windows/       - 窗口样式配置
  #
  # scripts/ 目录：
  #   包含各种实用脚本（截图、壁纸切换、动画切换等）
}
