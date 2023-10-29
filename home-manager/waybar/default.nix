{ 
  pkgs,
  config,
  inputs,
  ... 
}:

{
  programs.waybar = {
    enable = true;
    settings = {

      "bar" = {
        output = [ "DP-2" "!DP-7" ];
        position = "top";
        layer = "top";
        height = 29;
        width = null;
        exclusive = true;
        passthrough = false;
        spacing = 20;
        margin = null;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        fixed-center = true;
        ipc = true;

        modules-left = [ 
          "hyprland/workspaces"
        ];
        modules-center = [ 
          "custom/spotify" 
        ];
        modules-right = [
          "disk"
          "cpu"
          "temperature"
          "memory"
          "clock"
        ];

        "hyprland/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          "warp-on-scroll" = false;
          "format" = "{name}: {icon}";
          "format-icons" = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = " ";
            "urgent" = " ";
            "default" = " ";
            "focused" = " "; 
          };
        };

        "network" = {
          "interface" = "wlp12s0";
          "format" = "";
          "format-wifi" = " {signalStrength}%";
          "format-ethernet" = " ";
          "format-disconnected" = "󰖪";
          "tooltip-format" = "{ifname}";
          "tooltip-format-wifi" = "{essid}";
          "tooltip-format-ethernet" = "{ifname}";
          "tooltip-format-disconnected" = "Disconnected";
          "max-length" = 50;
        };

        "disk" = {
          "interval" = 30;
          "format" = "  {used}";
        };

        "cpu" = {
          "interval" = 5;
          "format" = "CPU: {}%";
          "max-length" = 10;
        };

        "memory" = {
          "interval" = 5;
          "format" = "RAM: {}%";
          "max-length" = 10;
        };

        "temperature" = {
          "hwmon-path" = "/sys/class/hwmon/hwmon3/temp1_input";
          "critical-threshhold" = 80;
          "format" = "{icon} {temperatureC}°C";
          "format-icons" = [ "" "" "" ];
        };

        "clock" = {
          "timezone" = "Europe/Berlin";
          "format" = "{:%d.%m.%Y %H:%M}";
          "tooltip" = true;
        };
        
        "custom/spotify" = let mediaScript = pkgs.writeShellScriptBin "mediaplayer" ''
            player_status=$(playerctl -p spotify status 2> /dev/null)

            artist=$(playerctl -p spotify metadata artist)
            title=$(playerctl -p spotify metadata title)
            if [ $player_status = "Playing" ]; then
              echo "{\"text\": \"$artist - $title\", \"class\": \"custom-spotify\", \"alt\": \"Spotify\"}"
            elif [ $player_status = "Paused" ]; then
              echo "{\"text\": \"  $artist - $title\", \"class\": \"custom-spotify\", \"alt\": \"Spotify (Paused)\"}"
            else
              echo null
            fi
          ''; in {
          "format" =  "  {}";
          "return-type" = "json";
          "interval" = 1;
          "max-length" = 60;
          "escape" = true;
          "exec" = "${mediaScript}/bin/mediaplayer 2> /dev/null";
          "on-click" = "playerctl -p spotify play-pause";
          "on-click-right" = "spotify 2> /dev/null";
          "on-scroll-up" = "playerctl -p spotify next";
          "on-scroll-down" = "playerctl -p spotify previous";
        };
      };
    };
    style = with config.colorScheme.colors; with inputs.nix-colors.lib.conversions; ''
      * {
        font-family: FontAwesome, "UbuntuMono Nerd Font", "GohuFont 11 Nerd Font";
        font-size: 19px;
      }

      window#waybar {
        background-color: transparent;
        /* rgba(${hexToRGBString ", " base00}, 0.5); */
      }


      #clock,
      #hyprland-workspaces,
      #custom-spotify,
      #batter,
      #cpu,
      #memory,
      #temperature,
      #disk {
        color: #${base04};
      }

      #clock {
        padding-right: 30px;
      }

      #workspaces {
        padding-left: 30px;
      }

      #workspaces button {
        background-color: transparent;
        color: #${base04};
      }

      #workspaces button:hover {
        background: rgba(256, 256, 256, 0.2);
      }

    '';
  };
}