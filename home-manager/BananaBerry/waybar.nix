{ config, pkgs, lib, ... }:

{
  # Waybar config file
  home.file.".config/waybar/config".text = ''
    {
      "layer": "top",
      "position": "top",

      "modules-left": [
        "custom/spacer",
        "hyprland/workspaces",
        "custom/spacer",
        "custom/usb",
        "custom/spacer",
        "pulseaudio"
      ],
      "modules-center": [
        "custom/spacer",
        "clock#1",
        "custom/spacer",
        "clock#2",
        "custom/spacer",
        "clock#3"
      ],
      "modules-right": [
        "memory",
        "custom/spacer",
        "cpu",
        "custom/spacer",
        "disk",
        "custom/spacer",
        "tray",
        "custom/spacer"
      ],

      "custom/spacer": {
        "format": "  ",
        "tooltip": false
      },

      "hyprland/workspaces": {
        "disable-scroll": true,
        "format": "{name}"
      },

      "custom/usb": {
        "format": "{}",
        "return-type": "json",
        "exec": "/home/cherry/.config/hypr/scripts/usb-devices.sh",
        "interval": 5,
        "tooltip": true
      },

      "clock#1": {
        "format": "{:%a}",
        "tooltip": false
      },
      "clock#2": {
        "format": "{:%H:%M}",
        "tooltip": false
      },
      "clock#3": {
        "format": "{:%m-%d}",
        "tooltip": false
      },

      "pulseaudio": {
        "format": "{icon} {volume:2}%",
        "format-bluetooth": "{icon}  {volume}%",
        "format-muted": "MUTE",
        "format-icons": {
          "headphones": "",
          "default": [
            "",
            ""
          ]
        },
        "scroll-step": 5,
        "on-click": "pavucontrol"
      },
      "memory": {
        "interval": 5,
        "format": "Mem {}%"
      },
      "cpu": {
        "interval": 5,
        "format": "CPU {usage:2}%"
      },
      "battery": {
        "states": {
          "good": 95,
          "warning": 30,
          "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-icons": [
          "",
          "",
          "",
          "",
          ""
        ]
      },
      "disk": {
        "interval": 5,
        "format": "Disk {percentage_used:2}%",
        "path": "/"
      },
      "tray": {
        "icon-size": 20
      }
    }
  '';

  # Waybar style file
  home.file.".config/waybar/style.css".text = ''
    * {
      font-size: 20px;
      font-family: monospace;
    }

    window#waybar {
      background: rgba(25, 25, 25, 0);
      color: #fdf6e3;
    }

    tooltip {
      color: rgba(30, 30, 30, 1);
      background-color: rgba(255, 255, 255, 0.85);
      border-color: rgba(142, 244, 255, 0.85);
      border-width: 6px;
      border-radius: 20px;
    }

    tooltip * {
      color: rgba(30, 30, 30, 1);
    }

    #workspaces,
    #clock.1,
    #clock.2,
    #clock.3,
    #pulseaudio,
    #memory,
    #cpu,
    #battery,
    #disk,
    #tray,
    #custom-usb {
      background: rgba(255, 255, 255, 1);
      margin-top: 6px;
      border-radius: 8px;
      border: 5px solid rgba(139, 169, 255, 1)
    }

    #workspaces button {
      padding: 0 2px;
      color:rgb(65, 73, 226);
      margin-bottom: 0px;
    }
    #workspaces button.focused {
      color: #268bd2;
    }
    #workspaces button:hover {
      box-shadow: inherit;
      text-shadow: inherit;
    }
    #workspaces button:hover {
      background:rgb(200, 200, 200);
    }

    #custom-usb {
      color: #d33682;
    }
    #custom-usb.usb-empty,
    #pulseaudio,
    #memory,
    #cpu,
    #battery,
    #disk,
    #clock {
      color:rgb(65, 73, 226);
    }

    #clock,
    #pulseaudio,
    #memory,
    #cpu,
    #battery,
    #disk,
    #tray,
    #workspaces,
    #custom-usb {
      padding: 0 10px;
    }
  '';
}