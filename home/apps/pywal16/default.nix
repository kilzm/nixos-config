{ ... }:
{
  programs.pywal16 = {
    enable = true;

    templates = {
      "colors-hyprland.conf" = ''
        $foreground = rgb({foreground.strip})
        $color0 = rgb({color0.strip})
        $color1 = rgb({color1.strip})
        $color2 = rgb({color2.strip})
        $color3 = rgb({color3.strip})
        $color4 = rgb({color4.strip})
        $color5 = rgb({color5.strip})
        $color6 = rgb({color6.strip})
        $color7 = rgb({color7.strip})
        $color8 = rgb({color8.strip})
        $color9 = rgb({color9.strip})
        $color10 = rgb({color10.strip})
        $color11 = rgb({color11.strip})
        $color12 = rgb({color12.strip})
        $color13 = rgb({color13.strip})
        $color14 = rgb({color14.strip})
        $color15 = rgb({color15.strip})
      '';
      "colors-foot.ini" = ''
        [colors]
        background={background.strip}
        foreground={foreground.strip}
        regular0={color0.strip}
        regular1={color1.strip}
        regular2={color2.strip}
        regular3={color3.strip}
        regular4={color4.strip}
        regular5={color5.strip}
        regular6={color6.strip}
        regular7={color7.strip}
        bright0={color8.strip}
        bright1={color9.strip}
        bright2={color10.strip}
        bright3={color11.strip}
        bright4={color12.strip}
        bright5={color13.strip}
        bright6={color14.strip}
        bright7={color15.strip}
      '';
    };
  };
}
