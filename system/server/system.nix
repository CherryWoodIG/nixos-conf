{ config, pkgs, lib, amdgpu-kernel-module, ... }:

{
  # Boot configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedUDPPorts = [
        53 1194 1195 1196 1197 1300 1301 1302 1303 1400 9600 8081
      ];
      allowedTCPPorts = [
        80 443 1401 9600 8081
      ];
    };
  };

  # Security
  security = {
    rtkit.enable = true;
  };

  # Locale, Timezone
  time.timeZone = "Europe/Stockholm";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };
  console.keyMap = "sv-latin1";
}