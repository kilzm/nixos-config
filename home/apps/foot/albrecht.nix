{ config, ... }:
{
  programs.foot = {
    settings = {
      main = {
        font = "${config.theming.fonts.mono}:size=13";
        line-height = 20;
        workers = 12;
      };
    };
  };
}
