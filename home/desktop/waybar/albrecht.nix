{ config, inputs, ... }: {
  programs.waybar = {
    settings = {
      bar = {
        output = "DP-1";
        height = 35;
        modules-right = [ "disk" "cpu" "temperature" "memory" "pulseaudio" "tray" ];
        temperature.hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
      };
    };

    style = import ./css.nix {
      font-size = 15;
      border-radius = 18;
      inherit (config.colorScheme) palette;
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
      inherit (config.theming.fonts) sans mono;
    };
  };
}
