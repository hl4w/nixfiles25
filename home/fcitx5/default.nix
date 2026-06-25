# =============================================================================
# Fcitx5 中文输入法配置
# =============================================================================
# 使用 Rime 输入法引擎和 Oh-My-Rime 配置
# =============================================================================

{ config, pkgs, lib, ... }:

let
  # ============================================================================
  # 外部配置包
  # ============================================================================

  # Oh-My-Rime - Rime 输入法配置框架
  # 提供开箱即用的 Rime 配置，支持多种输入方案
  oh-my-rime = pkgs.fetchzip {
    url = "https://cnb.cool/Mintimate/rime/oh-my-rime/-/releases/download/latest/oh-my-rime.zip";
    sha256 = "sha256-cSyGQhGJh5wTnArN1hmyaFJuFNILEc/7hcBvd2APfyQ=";
    stripRoot = false;
  };

  # Fcitx5 Catppuccin 主题
  # 提供与系统主题一致的深色/浅色主题支持
  fcitx5-catppuccin = pkgs.fetchzip {
    url = "https://gitee.com/hl4w/fcitx5-catppuccin/repository/archive/main.zip";
    sha256 = "sha256-ss0kW+ulvMhxeZKBrjQ7E5Cya+02eJrGsE4OLEkqKks=";
    stripRoot = true;
  };
in {
  # ============================================================================
  # 输入法基础配置
  # ============================================================================
  i18n.inputMethod = {
    enable = true;              # 启用输入法
    type = "fcitx5";          # 使用 Fcitx5 输入法框架

    fcitx5.addons = with pkgs; [
      fcitx5-rime              # Rime 输入法引擎
    ];
  };

  # ============================================================================
  # Rime 配置安装
  # ============================================================================
  # 使用 Home Manager 的激活钩子安装 Rime 配置
  home.activation.linkRimeConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # 创建 Fcitx5 配置目录
    run mkdir -p $HOME/.local/share/fcitx5

    # Rime 配置目标目录
    TARGET_DIR="$HOME/.local/share/fcitx5/rime"

    # 备份旧目录（已注释 - 如需备份可取消注释）
    #BACKUP_DIR="$TARGET_DIR.backup.$(date +%Y%m%d_%H%M%S)"
    #if [ -d "$TARGET_DIR" ] && [ ! -L "$TARGET_DIR" ]; then
    #  run mv "$TARGET_DIR" "$BACKUP_DIR"
    #  echo "Existing directory moved to $BACKUP_DIR"
    #fi

    # 复制 Oh-My-Rime 配置到目标目录
    # 不使用 unzip，直接复制解压后的文件
    run cp -rf ${oh-my-rime}/* "$TARGET_DIR/"

    # 设置文件权限
    # u+rwX: 用户读写执行（目录）
    run chmod -R u+rwX "$TARGET_DIR"

    echo "Oh-my-rime copied to $TARGET_DIR"
  '';

  # ============================================================================
  # 自定义默认输入方案
  # ============================================================================
  # 覆盖 Rime 默认配置，选择默认和辅助输入法方案
  home.file.".local/share/fcitx5/rime/default.custom.yaml".text = ''
    patch:
      # 候选词菜单设置
      menu:
        page_size: 6    # 每页显示 6 个候选词

      # 输入方案列表
      schema_list:
        # 主输入方案：雾凇拼音（带英文提示）
        - schema: rime_mint

        # 辅助输入方案：雾凇拼音 + 小鹤音形
        - schema: rime_mint_flypy
  '';

  # ============================================================================
  # Fcitx5 Catppuccin 主题安装
  # ============================================================================
  # 安装 Catppuccin 主题到 Fcitx5
  home.activation.linkCatppuccinConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # 创建 Fcitx5 主题目录
    run mkdir -p $HOME/.local/share/fcitx5/themes

    # 主题目标目录
    TARGET_DIR="$HOME/.local/share/fcitx5/themes"

    # 复制 Catppuccin 主题文件
    run cp -rf ${fcitx5-catppuccin}/src/* "$TARGET_DIR/"

    # 设置文件权限
    run chmod -R u+rwX "$TARGET_DIR"

    echo "Fcitx5 Catppuccin copied to $TARGET_DIR"
  '';

  # ============================================================================
  # Fcitx5 主题配置
  # ============================================================================
  # 配置 Fcitx5 ClassicUI 主题和外观
  xdg.configFile."fcitx5/conf/classicui.conf" = {
    force = true;
    text = ''
    # -------------------- 布局设置 --------------------
    # 垂直/水平候选词列表
    Vertical Candidate List=False
    # 滚轮翻页
    WheelForPaging=True

    # -------------------- 字体设置 --------------------
    # 候选词字体
    Font="思源黑体 12"
    # 菜单字体
    MenuFont="Sans 10"
    # 托盘字体
    TrayFont="Sans Bold 10"

    # -------------------- 托盘颜色 --------------------
    # 托盘轮廓颜色
    TrayOutlineColor=#000000
    # 托盘文字颜色
    TrayTextColor=#ffffff

    # -------------------- 图标和显示 --------------------
    # 优先显示文字图标
    PreferTextIcon=False
    # 在托盘图标中显示输入法名称
    ShowLayoutNameInIcon=True
    # 使用输入语言显示文本
    UseInputMethodLanguageToDisplayText=True

    # -------------------- 主题设置 --------------------
    # 浅色主题
    Theme=catppuccin-mocha-lavender
    # 深色主题
    DarkTheme=catppuccin-macchiato-blue
    # 禁用深色主题（强制使用浅色）
    UseDarkTheme=False
    # 使用强调色
    UseAccentColor=True

    # -------------------- DPI 设置 --------------------
    # 每个显示器独立 DPI
    PerScreenDPI=False
    # 强制 Wayland DPI（0 表示自动）
    ForceWaylandDPI=0
    # 启用分数缩放
    EnableFractionalScale=True
  '';
  };
}
