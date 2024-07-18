{ pkgs, host, ... }:
{
  imports = [ ./${host}.nix ];

  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        position = "top";
        layer = "top";
        fixed-center = true;
        exclusive = true;
        passthrough = false;
        ipc = true;
        reload_style_on_change = true;

        margin-bottom = -8;

        modules-left = [ "custom/logo" "hyprland/workspaces" "custom/spotify#icon" "custom/spotify#text" ];
        modules-center = [ "clock#calicon" "clock#caltext" "clock#clockicon" "clock#clocktext" ];

        "custom/logo" = { format = "󱄅 "; };

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = true;
          warp-on-scroll = true;
          format = "{name}";
        };

        "custom/spotify#icon" = {
          format = " ";
        };

        "custom/spotify#text" =
          let
            mediaScript = pkgs.writeShellScriptBin "mediaplayer" ''
              player_status=$(playerctl -p spotify status 2> /dev/null)
              artist=$(playerctl -p spotify metadata artist | sed 's/"/\\"/g')
              title=$(playerctl -p spotify metadata title | sed 's/"/\\"/g')
              if [ $player_status == "Playing" ]; then
                echo "{\"text\": \"$artist - $title\", \"class\": \"custom-spotify\", \"alt\": \"Spotify\"}"
              elif [ $player_status == "Paused" ]; then
                echo "{\"text\": \"  $artist - $title\", \"class\": \"custom-spotify\", \"alt\": \"Spotify (Paused)\"}"
              else
                echo null
              fi
            '';
          in
          {
            format = "{}";
            return-type = "json";
            interval = 1;
            max-length = 60;
            escape = true;
            exec = "${mediaScript}/bin/mediaplayer 2> /dev/null";
            on-click = "playerctl -p spotify play-pause";
            on-click-right = "spotify 2> /dev/null";
            on-scroll-up = "playerctl -p spotify next";
            on-scroll-down = "playerctl -p spotify previous";
            smooth-scrolling-threshold = 1;
          };

        "disk#icon" = {
          format = " ";
        };

        "disk#text" = {
          interval = 30;
          format = "{used}";
        };

        "cpu#icon" = {
          format = " ";
        };

        "cpu#text" = {
          interval = 5;
          format = "{usage}% ";
          max-length = 10;
        };

        temperature = {
          critical-threshold = 60;
          format = "| {temperatureC}°";
        };

        "memory#icon" = {
          format = " ";
        };

        "memory#text" = {
          interval = 5;
          format = "{}%";
          max-length = 10;
        };

        "clock#calicon" = {
          format = " ";
        };

        "clock#caltext" = {
          interval = 1;
          timezone = "Europe/Berlin";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>
          '';
          format = "{:%a, %d %b}";
        };

        "clock#clockicon" = {
          format = " ";
        };

        "clock#clocktext" = {
          interval = 1;
          timezone = "Europe/Berlin";
          format = "{:%H:%M}";
        };
      
        tray = { spacing = 10; };

        "pulseaudio#icon" = {
          format = "{icon}";
          format-muted = " ";
          format-icons = { default = [ " " " " ]; };
        };

        "pulseaudio#text" = {
          format = "{volume}%";
        };

        "battery#icon" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "󰂄";
          format-icons = [ "󰁻" "󰁿" "󰁹" ];
        };

        "battery#text" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}%";
        };
      };
    };
  };
}
