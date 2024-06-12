{ config, inputs, ... }: {
  programs.waybar = {
    settings = {
      bar = {
        output = "eDP-1";
        height = 35;
        modules-right = [ "disk" "cpu" "temperature" "memory" "pulseaudio" "battery" "tray" ];
        temperature.hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
      };
    };

    style = import ./css.nix {
      font-size = 16;
      border-radius = 16;
      inherit (config.colorScheme) palette;
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
      inherit (config.theming.fonts) sans mono;
    };
  };
}
