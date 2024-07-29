{ config, ... }:
{
  programs.foot = {
    settings = {
      main = {
        font = "${config.theming.fonts.mono}:size=15";
        line-height = 20;
        workers = 4;
      };
    };
  };
}
