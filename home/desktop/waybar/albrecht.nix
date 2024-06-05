{ config, inputs, ... }: {
  programs.waybar = {
    settings = {
      bar = {
        output = "DP-1";
        height = 36;
        modules-right = [ "disk" "cpu" "memory" "pulseaudio" "tray" ];
      };
    };

    style = import ./css.nix {
      font = config.theming.font;
      font-size = 15;
      border-radius = 18;
      inherit (config.colorScheme) palette;
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
    };
  };
}
