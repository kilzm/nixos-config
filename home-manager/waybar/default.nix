{ pkgs, config, host, ... }:
let
  inherit (config.colorScheme) palette;
  color = hex: str: ''<span color="#${hex}">${str}</span>'';
in {
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

        margin-top = 8;
        margin-bottom = -4;
        margin-left = 16;
        margin-right = 16;

        modules-left = [ "custom/logo" "hyprland/workspaces" "custom/spotify" ];
        modules-center = [ "clock" ];

        "custom/logo" = { format = " ${color "7DB5E0" "󱄅 "} "; };

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = true;
          warp-on-scroll = true;
          format = "{name}";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = " ";
            urgent = " ";
            default = " ";
            focused = " ";
          };
        };

        "custom/spotify" = let
          mediaScript = pkgs.writeShellScriptBin "mediaplayer" ''
            player_status=$(playerctl -p spotify status 2> /dev/null)
            artist=$(playerctl -p spotify metadata artist | sed 's/"/\\"/g')
            title=$(playerctl -p spotify metadata title | sed 's/"/\\"/g')
            if [ $player_status == "Playing" ]; then
              echo "{\"text\": \"$artist - $title\", \"class\": \"custom-spotify\", \"alt\": \"Spotify\"}"
            elif [ $player_status == "Paused" ]; then
              echo "{\"text\": \"  $artist - $title\", \"class\": \"custom-spotify\", \"alt\": \"Spotify (Paused)\"}"
            else
              echo null
            fi
          '';
        in {
          format = "${color palette.base0B " "} {}";
          return-type = "json";
          interval = 1;
          max-length = 60;
          escape = true;
          exec = "${mediaScript}/bin/mediaplayer 2> /dev/null";
          on-click = "playerctl -p spotify play-pause";
          on-click-right = "spotify 2> /dev/null";
          on-scroll-up = "playerctl -p spotify next";
          on-scroll-down = "playerctl -p spotify previous";
        };

        disk = {
          interval = 30;
          format = "${color palette.base0F " "} {used}";
        };

        cpu = {
          interval = 5;
          format = "${color palette.base0E " "} {usage}%";
          max-length = 10;
        };

        memory = {
          interval = 5;
          format = "${color palette.base0D " "} {}%";
          max-length = 10;
        };

        clock = {
          timezone = "Europe/Berlin";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format = " ${color palette.base0D " "} {:%a, %d %b   ${
               color palette.base0D " "
             } %R} ";
        };

        tray = { spacing = 10; };

        pulseaudio = {
          format = "${color palette.base0C "{icon} "} {volume}";
          format-muted = "${color palette.base0C "󰝟 "} {volume}";
          format-icons = { default = [ "" "" ]; };
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "${color palette.base0B "{icon} "} {capacity}%";
          format-chargin = "${color palette.base0B "󰂄 "} {capacity}%";
          format-plugged = "${color palette.base0B "󰂄 "} {capacity}%";
          format-icons = [ "󰁻" "󰁿" "󰁹" ];
        };
      };
    };
  };
}
