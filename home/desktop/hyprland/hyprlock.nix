{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    # package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    settings = {
      source = "~/.cache/wal/colors-hyprland.conf";

      background = [
        {
          monitor = "";
          path = "~/.wallpaper";
          contrast = 0.5;
          brightness = 0.8;
          vibrancy = 0.1;
        }
      ];

      input-field = [
        {
          rounding = 12;
          size = "300, 60";
          position = "0, 100";
          halign = "center";
          valign = "bottom";
          fade_on_empty = false;
          dots_size = 0.2;
          dots_spacing = 0.4;
          outline_thickness = 1;
          font_color = "0xff555555";
          inner_color = "0xee141414";
          outer_color = "0xff2a2a2a";
          check_color = "0xff2a2a2a";
          fail_color = "0xff2a2a2a";
          placeholder_text = "Type password.";
          font_family = "${config.theming.fonts.sans} Semibold";
        }
      ];

      label = [
        {
          text = ''cmd[update:1000] echo "$(date +"%R")"'';
          color = "$foreground";
          font_size = 120;
          position = "0, 60";
          halign = "center";
          valign = "center";
          font_family = "${config.theming.fonts.sans} Semibold";
        }
        {
          text = ''cmd[update:60000] echo "$(date +"%A, %B %d")"'';
          color = "$foreground";
          font_size = 20;
          position = "0, -60";
          halign = "center";
          valign = "center";
          font_family = "${config.theming.fonts.sans} Semibold";
        }
      ];
    };
  };
}
