{ pkgs,  ... }:

{
  #### 引导与系统内核
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;
  boot.initrd.verbose = false; #精简启动日志，配合 Plymouth 开机画面更干净。
  boot.initrd.systemd.enable = true; #必须开启，否则 Plymouth 很容易黑屏、闪文字、动画异常。

  #boot.initrd.availableKernelModules = [ "i915" ];
  #boot.initrd.kernelModules          = [ "i915" ];

  # Plymouth 开机画面
  boot.plymouth = {
    enable = true;
    theme = "nixos-breeze";
    #logo = "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake.png";
  };
  boot.kernelParams = [
    "quiet" "splash"
    "intel_iommu=on"
    "iommu=pt"
    # 显卡 / virgl 虚拟 GPU
    "drm.vblankoffdelay=0"
    "nvme.noacpi=1"

    # 改善 Hyprland 鼠标/触摸
    "usbhid.mousepoll=0"

    # 解决一些笔记本休眠/电源问题
    "mem_sleep_default=s2idle"
    "pcie_aspm=off"
  ];
  
  boot.consoleLogLevel = 3;
  boot.supportedFilesystems = [ "ntfs" ];

  
}
