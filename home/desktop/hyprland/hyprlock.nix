{ config, inputs, pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      source = "~/.cache/wal/colors-hyprland.conf";

      background = [{
        monitor = "";
        path = "$wallpaper";
        blur_passes = 3;
        blur_size = 15;

        contrast = 0.8;
        brightness = 0.8;
        vibrancy = 0.1;
      }];

      input-field = [{
        size = "200, 50";
        position = "0, -140";
        halign = "center";
        valign = "center";
        font_color = "$background";
        inner_color = "$foreground";
        outer_color = "$foreground";
        check_color = "$color5";
        fail_color = "$color3";
      }];

      label = [
        {
          text = ''cmd[update:1000] echo "$(date +"%R")"'';
          color = "$foreground";
          font_size = 120;
          position = "0, -300";
          halign = "center";
          valign = "top";
          font_family = "${config.theming.fonts.sans} Bold";
        }
      ];
    };
  };
}
