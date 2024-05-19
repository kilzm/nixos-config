{ cmn, config, inputs, ... }:
{
  programs.waybar = {
    settings = {
      bar = {
        output = "DP-1";
        height = 34;
        modules-right = [
          "disk"
          "cpu"
          "memory"
          "pulseaudio"
          "tray"
        ];
      };
    };

    style = import ./css.nix {
      font = cmn.font;
      font-size = 15;
      border-radius = 20;
      inherit (config.colorScheme) palette;
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
    };
  };
}
