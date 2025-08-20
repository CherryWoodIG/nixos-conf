{ config, pkgs, lib, ... }:

{
  # Hypridle configuration file
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch dpms on
    inhibit_sleep = 0
    }

    # Dim screen after 5 minutes of inactivity
    listener {
      timeout = 300
      on-timeout = brightnessctl -s set 10
      on-resume = brightnessctl -r
    }

    # Turn off keyboard backlight after 5 minutes
    listener {
      timeout = 300
      on-timeout = brightnessctl -sd platform::kbd_backlight set 0
      on-resume = brightnessctl -rd platform::kbd_backlight
    }

    # Lock screen after 10 minutes
    listener {
    timeout = 600
    on-timeout = loginctl lock-session
    }

    # Turn off display after 15 minutes
    listener {
      timeout = 900
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }

    # Suspend system after 30 minutes
    listener {
      timeout = 1800
      on-timeout = systemctl suspend
    }
  '';

  # Hyprpaper configuration file
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /etc/nixos/wallpaper.png
    wallpaper = , contain:/etc/nixos/wallpaper.png
  '';

  # Hyprlock configuration
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 5;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          monitor = "";
          path = "/etc/nixos/wallpaper.png";
          blur_passes = 3;
          blur_size = 8;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # Clock
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M %p\")\"";
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 55;
          font_family = "Roboto";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = "cmd[update:43200000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(255, 255, 255, 0.8)";
          font_size = 22;
          font_family = "Roboto";
          position = "0, 240";
          halign = "center";
          valign = "center";
        }
        # Battery status
        {
          monitor = "";
          text = "cmd[update:5000] /home/cherry/.config/hypr/scripts/battery-status.sh";
          color = "rgba(255, 255, 255, 0.9)";
          font_size = 18;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, -250";
          halign = "center";
          valign = "center";
        }
        # User info
        {
          monitor = "";
          text = "  $USER";
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 16;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, -50";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "350, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgba(255, 255, 255, 0.75)";
          fade_on_empty = false;
          font_family = "JetBrains Mono Nerd Font";
          placeholder_text = "<i><span foreground=\"##ffffff75\">Enter Password...</span></i>";
          hide_input = false;
          position = "0, 0";
          halign = "center";
          valign = "center";
          zindex = 10;
        }
      ];
    };
  };
}