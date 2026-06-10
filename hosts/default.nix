{ config, pkgs, inputs, lib, username, ... }:

{
  imports = [
    ../modules/bootloader.nix
    ../modules/hardware.nix
    ./hardware-configuration.nix
    ../modules/flatpak-module.nix
    ../modules/gc.nix
    ../modules/chinese.nix
    ../modules/ai-robot.nix
    # ../modules/auto-upgrade.nix
    # ../modules/virtualization.nix
    ../modules/hyprland.nix
  ];

  nix.package = pkgs.lix;
  nix.settings = {
    connect-timeout = 5;
    fallback = true;
    auto-optimise-store = true;
  };

  programs.zsh.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "video" "audio" "render" "libvirtd" "qemu" "kvm" ];
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = true;
    openFirewall = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  environment.shellAliases = {
    "torch-dev" = "docker run -it --rm --gpus all -v ~/projects:/workspace pytorch/pytorch:latest";
  };

  system.stateVersion = "25.11";
}