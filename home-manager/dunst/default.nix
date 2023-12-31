{
  config,
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
      separator_height = 3;
      frame_width = 3;
      padding = 8;
      text_icon_padding = 15;
      separator_color = "frame";
      idle_threshold = 120;
      font = "${cmn.font} 12";
      line_height = 0;
      format = ''<b>%s</b>\n%b'';
      alignment = "left";
      icon_position = "left";
      corner_radius = 7;

      frame_color = "#${c.base03}";
      background = "#${c.base00}";
      foreground = "#${c.base05}";
    };
  };
}
