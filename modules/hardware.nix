{ pkgs, hostname, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  services.printing.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  time.hardwareClockInLocalTime = true;
  time.timeZone = "Asia/Shanghai";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.gvfs.enable = true;
  virtualisation.vmware.guest.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.bluedevil
    kdePackages.plasma-nm
    vulkan-loader
    vulkan-tools
  ];
}
