{ config, ... }: {
  programs.waybar = {
    settings = {
      bar = {
        output = "DP-1";
        height = 35;
        modules-right = [ 
          "disk#icon"
          "disk#text"
          "cpu#icon"
          "cpu#text"
          "temperature"
          "memory#icon"
          "memory#text"
          "pulseaudio#icon"
          "pulseaudio#text"
          "tray"
        ];
        temperature.hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
      };
    };

    style = import ./css.nix {
      font-size = 15;
      border-radius = 18;
      inherit (config.theming.fonts) sans mono;
    };
  };
}
