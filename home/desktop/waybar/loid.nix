{ config, inputs, ... }: {
  programs.waybar = {
    settings = {
      bar = {
        output = "eDP-1";
        height = 45;
        modules-right = [ "disk" "cpu" "memory" "pulseaudio" "battery" "tray" ];
      };
    };

    style = import ./css.nix {
      font = config.theming.font;
      font-size = 20;
      border-radius = 28;
      inherit (config.colorScheme) palette;
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
    };
  };
}
