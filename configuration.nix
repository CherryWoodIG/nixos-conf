{ config, pkgs, lib, ... }:

let
  hostname = "BananaBerry";
in
{
  # User
  users.users.cherry = {
    isNormalUser = true;
    description = "cherry";
    home = "/home/cherry";
    extraGroups = [ "networkmanager" "wheel" "video" "realtime" ];
    packages = with pkgs; [];
  };

  # General imports
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ] ++ lib.optionals (hostname == "ApricotBerry") [
    ./hosts/ApricotBerry.nix
  ] ++ lib.optionals (hostname == "BananaBerry") [
    ./hosts/BananaBerry.nix
  ] ++ lib.optionals (hostname == "CherryBerry") [
    ./hosts/CherryBerry.nix
  ];

  # misc
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
}