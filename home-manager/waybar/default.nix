{ 
  pkgs,
  config,
  inputs,
  cmn,
  lib,
  host,
  ... 
}:

let hcfg = import ./${host}.nix;
in
{
  programs.waybar = {
    enable = true;
    settings = {
      "bar" = {
        inherit (hcfg) output height;
        position = "top";
        layer = "top";
        width = null;
        exclusive = true;
        passthrough = false;
        spacing = 0;
        margin-top = 8;
        margin-bottom = -4;
        margin-left = 16;
        margin-right = 16;
        fixed-center = true;
        ipc = true;

        modules-left = [ 
          "hyprland/workspaces"
          "custom/spotify"
        ];
        modules-center = ["clock"];
        inherit (hcfg) modules-right;

        "hyprland/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          "warp-on-scroll" = false;
          "format" = "{name}";
        };

        "hyprland/window" = {
          "format" = "{}";
          "max-length" = 60; 
          "multiple-outputs" = true;
        };

        "disk" = {
          "interval" = 30;
          "format" = "<span color=\"#${config.colorScheme.palette.base0F}\"> </span> {used}";
        };

        "cpu" = {
          "interval" = 5;
          "format" = "<span color=\"#${config.colorScheme.palette.base0E}\"> </span> {usage}%";
          "max-length" = 10;
        };

        "memory" = {
          "interval" = 5;
          "format" = "<span color=\"#${config.colorScheme.palette.base0D}\"> </span> {}%";
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
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format" = " <span color=\"#${config.colorScheme.palette.base0D}\">󰃭 </span> {:%a, %d %b  <span color=\"#${config.colorScheme.palette.base0D}\"> </span>  %I:%M %p} ";
        };

        "tray" = {
          "spacing" = 10;
        };
        
        "pulseaudio" = {
          "format" = "<span color=\"#${config.colorScheme.palette.base0C}\">{icon}</span>  {volume}";
          "format-muted" = "<span color=\"#${config.colorScheme.palette.base0C}\">󰝟 </span> {volume}"; 
          "format-icons" = {
            "default" = [ "" "" ];
          };
        };

        "battery" = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "<span color=\"#${config.colorScheme.palette.base0B}\">{icon}</span> {capacity}%";
          "format-charging" = "󰂄";
          "format-plugged" = "󰂄";
          "format-icons" = [ "󰁻" "󰁿" "󰁹" ];
        };

        "idle_inhibitor" = {
          "format" = "{icon} ";
          "tooltip" = true;
          "format-icons" = {
            "activated" = "󰐥";
            "deactivated" = "󰐥";
          };
          "on-click-right" = "hyprlock";
        };
        
        "custom/spotify" = let mediaScript = pkgs.writeShellScriptBin "mediaplayer" ''
            player_status=$(playerctl -p spotify status 2> /dev/null)
            artist=$(playerctl -p spotify metadata artist)
            title=$(playerctl -p spotify metadata title)
            if [ $player_status == "Playing" ]; then
              echo "{\"text\": \"$artist - $title\", \"class\": \"custom-spotify\", \"alt\": \"Spotify\"}"
            elif [ $player_status == "Paused" ]; then
              echo "{\"text\": \"  $artist - $title\", \"class\": \"custom-spotify\", \"alt\": \"Spotify (Paused)\"}"
            else
              echo null
            fi
          ''; in {
          "format" =  "<span color=\"#${config.colorScheme.palette.base0B}\"> </span>  {}";
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
    style = with config.colorScheme.palette; with inputs.nix-colors.lib.conversions; ''
      * {
        font-family: FontAwesome, "${cmn.font}";
        font-size: ${builtins.toString hcfg.font-size}px;
        font-weight: 600;
      }
      
      /* main waybar */
      window#waybar {
        background: rgba(${hexToRGBString ", " base01}, 0);
      }
      
      #workspaces {
        padding: 0px 5px;
        border-radius: ${hcfg.border-radius}px;
        color: #${base05};
      }
      
      #workspaces button {
        border-bottom: 1.5px solid transparent;
        border-radius: 0;
        color: #${base05};
      }
      
      #workspaces button.active {
        border-bottom: 1.5px solid #${base0D};
        color: #${base0D};
      }
      
      #workspaces button:hover {
        background: rgba(256, 256, 256, 0.2);
      }
      
      #custom-spotify {
        margin: 0px 20px;
        padding: 0px 15px;
        border-radius: ${hcfg.border-radius}px;
        color: #${base05};
      }
      
      
      #clock {
        border-radius: ${hcfg.border-radius}px;
        padding: 0px 20px;
        color: #${base05};
      }
      
      #disk {
        border-top-left-radius: ${hcfg.border-radius}px;
        border-bottom-left-radius: ${hcfg.border-radius}px;
        color: #${base0F}
      }
      
      #cpu {
        color: #${base0E};
      }
      
      #memory {
        border-top-right-radius: ${hcfg.border-radius}px;
        border-bottom-right-radius: ${hcfg.border-radius}px;
        margin-right: 20px;
        color: #${base0D}
      }
      
      #pulseaudio {
        border-top-left-radius: ${hcfg.border-radius}px;
        border-bottom-left-radius: ${hcfg.border-radius}px;
        color: #${base0C};
      }
      
      #battery {
        color: #${base0B}
      }
      
      #tray {
        border-top-right-radius: ${hcfg.border-radius}px;
        border-bottom-right-radius: ${hcfg.border-radius}px;
      }
      
      #workspaces,
      #custom-spotify,
      #disk,
      #cpu,
      #memory,
      #battery,
      #pulseaudio,
      #clock,
      #tray {
        background: rgba(${hexToRGBString ", " base00}, 0.95);
        padding: 0px 15px;
        color: #${base05};
      }
    '';
  };
}
