{ config, pkgs, lib, ... }:

{
  networking.hostName = "CherryBerry";

  imports = [
    ../system/desktop/system.nix
    ../system/desktop/environment.nix
    ../system/desktop/packages.nix
  ];

  home-manager = {
    backupFileExtension = "backupp";
    useUserPackages = true;
    useGlobalPkgs = true;
    users.cherry = {
      imports = [
        ../home-manager/base.nix
        ../home-manager/bash.nix
        ../home-manager/hypr-tools.nix
        ../home-manager/scripts.nix
        ../home-manager/CherryBerry/waybar.nix
        ../home-manager/CherryBerry/hyprland.nix
      ];
    };
  };
}