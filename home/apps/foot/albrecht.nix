{ config, ... }:
{
  programs.foot = {
    settings = {
      main = {
        font = "${config.theming.fonts.mono}:size=12.5";
        dpi-aware = "yes";
        line-height = 16.5;
        workers = 12;
      };
      colors = {
        alpha = 0.85;
      };
    };
  };
}
