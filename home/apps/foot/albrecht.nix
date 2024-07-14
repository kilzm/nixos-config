{ config, ... }:
{
  programs.foot.settings.main.font = "${config.theming.fonts.mono}:size=11";
}
