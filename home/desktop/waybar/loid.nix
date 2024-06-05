{ config, inputs, ... }: {
  programs.waybar = {
    settings = {
      bar = {
        output = "eDP-1";
        height = 35;
        modules-right = [ "disk" "cpu" "memory" "pulseaudio" "battery" "tray" ];
      };
    };

    style = import ./css.nix {
      font = config.theming.font;
      font-size = 17;
      border-radius = 20;
      inherit (config.colorScheme) palette;
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
    };
  };
}
