{ config, host, ... }: {
  imports = [ ./${host}.nix ];

  services.dunst = {
    enable = true;
    settings.global =
      let c = config.colorScheme.palette;
      in {
        origin = "top-right";
        follow = "mouse";
        offset = "30x30";
        separator_height = 2;
        frame_width = 2;
        padding = 8;
        text_icon_padding = 15;
        separator_color = "frame";
        idle_threshold = 120;
        line_height = 0;
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        icon_position = "left";
        corner_radius = 16;

        frame_color = "#${c.base03}";
        background = "#${c.base00}CD";
        foreground = "#${c.base05}";
      };
  };
}
