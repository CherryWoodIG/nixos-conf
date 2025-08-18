{ config, pkgs, lib, ... }:

{
  fonts.fontconfig.enable = true;

  home = {
    username = "cherry";
    homeDirectory = "/home/cherry";
    stateVersion = "24.11";
    enableNixpkgsReleaseCheck = false;

    # User Packages
    packages = with pkgs; [
      bibata-cursors
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      nerd-fonts.dejavu-sans-mono
      font-awesome
      roboto
    ];

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 32;
    };
  };

  # GTK Theme
  gtk = {
    enable = true;

    theme = {
      name = "Breeze";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = "Adwaita";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  # QT Theme
  qt = {
    enable = true;
    style = {
      name = "breeze";
      package = pkgs.kdePackages.breeze;
    };
  };

  # XDG Portal
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = [ "hyprland" "gtk" ];
        hyprland.default = [ "hyprland" "gtk" ];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  # Add fontconfig configuration
  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Noto Sans</family>
          <family>DejaVu Sans</family>
        </prefer>
      </alias>
      <alias>
        <family>serif</family>
        <prefer>
          <family>Noto Serif</family>
          <family>DejaVu Serif</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>FiraCode Nerd Font</family>
          <family>DejaVu Sans Mono</family>
        </prefer>
      </alias>
    </fontconfig>
  '';
}