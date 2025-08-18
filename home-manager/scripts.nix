{ config, pkgs, lib, ... }:

{
  # Battery status script
  home.file.".config/hypr/scripts/battery-status.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Check if battery exists
      if [ ! -d /sys/class/power_supply/BAT* ]; then
        echo " "
        exit 0
      fi

      # Get battery information
      BATTERY_PATH=$(find /sys/class/power_supply -name "BAT*" | head -n 1)
      CAPACITY=$(cat "''${BATTERY_PATH}/capacity" 2>/dev/null || echo "0")
      STATUS=$(cat "''${BATTERY_PATH}/status" 2>/dev/null || echo "Unknown")

      # Function to get battery icon based on capacity and status
      get_battery_icon() {
        local capacity=$1
        local status=$2
        
        if [[ "$status" == "Charging" ]]; then
          echo ""  # Font Awesome charging icon
        elif [[ $capacity -ge 90 ]]; then
          echo ""  # Font Awesome full battery
        elif [[ $capacity -ge 75 ]]; then
          echo ""  # Font Awesome 3/4 battery
        elif [[ $capacity -ge 50 ]]; then
          echo ""  # Font Awesome 1/2 battery
        elif [[ $capacity -ge 25 ]]; then
          echo ""  # Font Awesome 1/4 battery
        else
          echo ""  # Font Awesome empty battery
        fi
      }

      # Function to get color based on battery level
      get_battery_color() {
        local capacity=$1
        local status=$2
        
        if [[ "$status" == "Charging" ]]; then
          echo "#00ff00"  # Green for charging
        elif [[ $capacity -le 15 ]]; then
          echo "#ff0000"  # Red for critical
        elif [[ $capacity -le 30 ]]; then
          echo "#ff8800"  # Orange for low
        else
          echo "#ffffff"  # White for normal
        fi
      }

      # Get the appropriate icon and color
      ICON=$(get_battery_icon "$CAPACITY" "$STATUS")
      COLOR=$(get_battery_color "$CAPACITY" "$STATUS")

      # Format the output with icon and percentage
      echo "<span color='$COLOR'>$ICON $CAPACITY%</span>"
    '';
    executable = true;
  };

  # USB devices script
  home.file.".config/hypr/scripts/usb-devices.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Build speed mapping from lsusb -t
      declare -A speed_map
      current_bus=""
      while IFS= read -r line; do
        # Track current bus from root hub lines
        if [[ "$line" =~ ^/: ]]; then
          [[ "$line" =~ Bus\ ([0-9]+)\. ]] && current_bus="''${BASH_REMATCH[1]}"
        # Process device lines with speed information
        elif [[ -n "$current_bus" && "$line" =~ Dev\ ([0-9]+).*,\ ([0-9]+[MG])$ ]]; then
          device="''${BASH_REMATCH[1]}"
          speed="''${BASH_REMATCH[2]}"
          # Create bus:device key (remove leading zeros)
          key="$((10#$current_bus)):$((10#$device))"
          speed_map["$key"]="$speed"
        fi
      done < <(lsusb -t 2>/dev/null)

      # Process USB devices
      device_count=0
      usb_info=""
      while IFS= read -r line; do
        if [[ "$line" =~ Bus\ ([0-9]+)\ Device\ ([0-9]+):\ ID\ [0-9a-fA-F]+:[0-9a-fA-F]+\ (.+) ]]; then
          bus="''${BASH_REMATCH[1]}"
          device="''${BASH_REMATCH[2]}"
          device_name="''${BASH_REMATCH[3]}"
          
          # Skip root hubs
          [[ "$device_name" == *"root hub"* ]] && continue
          [[ "$device_name" == *"Root Hub"* ]] && continue
          
          # Get speed from map (remove leading zeros from bus/device)
          key="$((10#$bus)):$((10#$device))"
          speed="''${speed_map[$key]:-Unknown}"
          
          # Clean device name
          clean_name=$(echo "$device_name" | sed -e 's/^ *//' -e 's/ *$//' -e 's/  */ /g')
          [[ ''${#clean_name} -gt 40 ]] && clean_name="''${clean_name:0:37}..."
          
          # Add to USB info
          usb_info+="• $clean_name\n - $speed\n"
          ((device_count++))
        fi
      done < <(lsusb 2>/dev/null)

      # Generate JSON output
      if [[ $device_count -eq 0 ]]; then
        echo '{"text": " 0", "tooltip": "No USB devices connected", "class": "usb-empty"}'
      else
        # Remove trailing newline
        usb_info="''${usb_info%\\n}"
        echo "{\"text\": \"USB: $device_count\", \"tooltip\": \"Connected USB devices:\\n\\n$usb_info\", \"class\": \"usb-devices\"}"
      fi
    '';
    executable = true;
  };

  home.file.".config/kitty/kitty.conf" = {
    text = ''
      # Catppuccin Latte Color Scheme
      foreground   #4C4F69
      background   #EFF1F5
      cursor   #DC8A78
      selection_foreground   #EFF1F5
      selection_background   #7287FD

      # Black & White
      color0   #EFF1F5
      color8   #BCC0CC

      # Red
      color1   #D20F39
      color9   #D20F39

      # Green
      color2   #40A02B
      color10  #40A02B

      # Yellow
      color3   #DF8E1D
      color11  #DF8E1D

      # Blue
      color4   #1E66F5
      color12  #1E66F5

      # Magenta
      color5   #EA76CB
      color13  #EA76CB

      # Cyan
      color6   #179299
      color14  #179299

      # White
      color7   #ACB0BE
      color15  #ACB0BE

      # Advanced Settings
      window_padding_width 8
      font_size 12.0
      cursor_shape beam
      cursor_beam_thickness 1.8
    '';
  };
}