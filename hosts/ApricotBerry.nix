{ config, pkgs, lib, ... }:

{
  networking.hostName = "ApricotBerry";

  imports = [
    ../system/server/system.nix
    ../system/server/environment.nix
    ../system/server/packages.nix
  ];

  home-manager = {
    backupFileExtension = "backupp";
    useUserPackages = true;
    useGlobalPkgs = true;
    users.cherry = {
      imports = [
        ../home-manager/bash.nix
      ];
    };
  };
}