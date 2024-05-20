{ inputs, config, ... }:
let c = config.colorScheme.palette;
in {
  programs.hyprlock =
    let
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
      hexToRGB = hexToRGBString ", ";
    in
    {
      enable = true;
      settings = {
        background = [{
          monitor = "";
          path = "${config.wallpaper.normal}";
          blur_passes = 2;
          blur_size = 7;

          contrast = 0.8;
          brightness = 0.8;
          vibrancy = 0.2;
        }];

        input-field = [{
          size = "200, 50";
          position = "0, -120";
          halign = "center";
          valign = "center";
          font_color = "rgb(${hexToRGB c.base03})";
          inner_color = "rgba(${hexToRGB c.base01}, 0.8)";
          outer_color = "rgba(${hexToRGB c.base01}, 0.8)";
          check_color = "rgb(${hexToRGB c.base06})";
          fail_color = "rgb(${hexToRGB c.base08})";
          font_family = "${config.theming.font}";
        }];

        label = [
          {
            text = ''cmd[update:1000] echo "$(date +"%R")"'';
            color = "rgba(${hexToRGB c.base01}, 0.8)";
            font_size = 120;
            position = "0, -300";
            halign = "center";
            valign = "top";
            font_family = "${config.theming.font} Bold";
          }
          {
            text = "Servus, Kilian";
            color = "rgba(${hexToRGB c.base01}, 0.8)";
            font_size = 25;
            position = "0, -40";
            halign = "center";
            valign = "center";
            font_family = "${config.theming.font} SemiBold";
          }
        ];
      };
    };
}
