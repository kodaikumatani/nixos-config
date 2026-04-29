{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # ===== Nix / nixpkgs =====
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # ===== Boot loader (GRUB + EFI) =====
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  # ===== Networking =====
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # ===== Locale / Time =====
  time.timeZone = "Asia/Tokyo";

  # ===== Graphics (NVIDIA) =====
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    # オープンソース版カーネルモジュール（Turing 世代以降推奨）
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # ===== Audio (PipeWire) =====
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # ===== Desktop (X11 / Wayland + SDDM + KDE Plasma 6) =====
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb.layout = "us";
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # ===== Users =====
  users.users.kodaikumatani = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    initialPassword = "changeme";
  };

  # ===== Services =====
  services.openssh.enable = true;

  # ===== Programs =====
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # ===== System packages =====
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
  ];

  # 初回インストール時の NixOS バージョン。互換性のため変更しない
  system.stateVersion = "25.11";
}
