{ config, pkgs, lib, ... }:

{
  # System Packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  # Programs
  programs = {
    
  };

  # Services
  services = {
    displayManager.autoLogin.user = "cherry";
    dbus.enable = true;
    xserver.xkb = {
      layout = "se";
      variant = "nodeadkeys";
    };
  };
}