{ config, pkgs, lib, ... }:

{
  networking.hostName = "BananaBerry";

  imports = [
    ../system/desktop/environment.nix
    ../system/desktop/packages.nix
    ../system/desktop/system.nix
  ];

  home-manager = {
    backupFileExtension = "backupp";
    useUserPackages = true;
    useGlobalPkgs = true;
    users.cherry = {
      imports = [
        ../home-manager/base.nix
        ../home-manager/bash.nix
        ../home-manager/scripts.nix
        ../home-manager/BananaBerry/hypr-tools.nix
        ../home-manager/BananaBerry/waybar.nix
        ../home-manager/BananaBerry/hyprland.nix
      ];
    };
  };
}