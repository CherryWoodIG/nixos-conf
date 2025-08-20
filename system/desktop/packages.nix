{ config, pkgs, lib, ... }:

{
  # System Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    networkmanagerapplet
    kdePackages.dolphin
    discord-canary
    kitty
    waybar
    pavucontrol
    font-awesome
    hyprcursor
    hyprpaper
    hyprpicker
    bibata-cursors
    wlogout
    adwaita-icon-theme
    qgnomeplatform
    dunst
    libnotify
    wofi
    vscode
    lxqt.lxqt-policykit
    nerd-fonts.fira-code
    nerd-fonts.dejavu-sans-mono
    neofetch
    jq
    noto-fonts-emoji
    papirus-icon-theme
    slurp
    grim
    wf-recorder
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-utils
    wlr-randr
    qt6.qtwayland
    qt5.qtwayland
    kdePackages.xwaylandvideobridge
    kdePackages.ark
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.gwenview
    libadwaita
    heroic
    playerctl
    wl-clipboard
    cliphist
    wl-clip-persist
    hyprlock
    hypridle
    lact
    vesktop
    usbutils
    spotify
    curl
    openssl
    qbittorrent-enhanced
    mpv
    oversteer
    git
    protontricks
    protonup-qt
    wineWowPackages.stable
    krita
    inkscape
    prusa-slicer
    qpwgraph
    gamescope
    obs-studio
    bottles
    alsa-utils
    ftb-app
    prismlauncher
    exiftool
    strawberry
    mangohud
    goverlay
    libreoffice-qt6-still
    brightnessctl
    (catppuccin-sddm.override {
      flavor = "latte";
      font  = "Noto Sans";
      fontSize = "16";
      background = "${/home/cherry/nixos-conf/wallpaper.png}";
      loginBackground = true;
    })
  ];

  # Programs
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    dconf.enable = true;
    appimage.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    nerd-fonts.dejavu-sans-mono
    font-awesome
    roboto
  ];

  # Services
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-latte";
      package = pkgs.kdePackages.sddm;
    };
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    xserver.xkb = {
      layout = "se";
      variant = "nodeadkeys";
    };
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    flatpak.enable = true;
    sunshine =  {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
    lact.enable = true;
    udisks2.enable = true;
  };

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  # Nix package configs
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.05"
  ];
}