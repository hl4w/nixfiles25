{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    # 升级模式：boot 更安全（仅下载更新，下次开机生效，避免运行中系统变更）
    operation = "boot";
    # Flake配置路径（与你的flake.nix位置一致）
    flake = "~/nixfiles";
    # 升级参数：更新nixpkgs、提交锁文件、静默执行
    flags = [
      "--update-input" "nixpkgs"
      "--update-input" "hyprland"
      #"--update-input" "niri"
      "--update-input" "home-manager"
      "--commit-lock-file"
      "--verbose"
    ];
    # 每周日凌晨2点自动升级（避免影响使用）
    #dates = "Sun *-*-* 02:00:00";
    dates = "weekly";
    # 升级前自动备份系统（推荐）
    backup = {
      enable = true;
      # 保留5个备份
      keep = 3;
    };
    # 升级失败自动邮件通知（可选，需配置邮件服务）
    # notificationEmail = "your-email@example.com";
  };
}
