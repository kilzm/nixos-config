{ config, ... }: {
  programs.waybar = {
    settings = {
      bar = {
        output = "eDP-1";
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
          "battery#icon"
          "battery#text"
          "tray"
        ];
        temperature.hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
      };
    };

    style = import ./css.nix {
      font-size = 16;
      border-radius = 16;
      inherit (config.theming.fonts) sans mono;
    };
  };
}
