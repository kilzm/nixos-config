{
  lib,
  pkgs,
  config,
  inputs,
  cmn,
  ...
}:

{
  services.dunst = {
    enable = true;
    settings.global = 
      let c = config.colorScheme.colors; 
      in {
      origin = "top-right";
      follow = "mouse";
      offset = "50x50";
      separator_height = 2;
      frame_width = 2;
      padding = 8;
      text_icon_padding = 15;
      separator_color = "frame";
      idle_threshold = 120;
      font = "${cmn.font} 12";
      line_height = 0;
      format = ''<b>%s</b>\n%b'';
      alignment = "left";
      icon_position = "left";
      corner_radius = 0;

      frame_color = "#${c.base0D}";
      background = "#${c.base02}";
      foreground = "#${c.base06}";
    };
  };
}
