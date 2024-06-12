{ lib, pkgs, config, ... }: {
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    font = "${config.theming.fonts.sans} 13";
    terminal = "kitty";

    plugins = with pkgs; [
      (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
      rofi-power-menu
      (rofi-emoji.override { rofi-unwrapped = rofi-wayland-unwrapped; })
    ];

    extraConfig = {
      modi = lib.concatStringsSep "," [
        "run"
        "drun"
        "emoji"
        "power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu"
      ];
      show-icons = true;
    };

    theme =
      let inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" =
          let c = config.colorScheme.palette;
          in {
            background = mkLiteral "#${c.base00}";
            background-color = mkLiteral "transparent";
            lightbg = mkLiteral "#${c.base03}";

            black = mkLiteral "#${c.base01}";
            grey = mkLiteral "#${c.base04}";
            red = mkLiteral "#${c.base08}";
            blue = mkLiteral "#${c.base0D}";

            normal-background = mkLiteral "@background";
            active-background = mkLiteral "@lightbg";
            urgent-background = mkLiteral "@background";
            selected-normal-background = mkLiteral "@active-background";
            selected-active-background = mkLiteral "@active-background";
            selected-urgent-background = mkLiteral "@red";
            alternate-urgent-background = mkLiteral "@lightbg";
            alternate-active-background = mkLiteral "@lightbg";
            alternate-normal-background = mkLiteral "#${c.base00}";

            foreground = mkLiteral "#${c.base05}";

            normal-foreground = mkLiteral "@foreground";
            active-foreground = mkLiteral "@foreground";
            urgent-foreground = mkLiteral "@red";
            selected-normal-foreground = mkLiteral "@foreground";
            selected-active-foreground = mkLiteral "@foreground";
            selected-urgent-foreground = mkLiteral "@foreground";
            alternate-normal-foreground = mkLiteral "@foreground";
            alternate-active-foreground = mkLiteral "@foreground";
            alternate-urgent-foreground = mkLiteral "@foreground";

            border-color = mkLiteral "#${c.base03}";
            separator-color = mkLiteral "@foreground";
            spacing = mkLiteral "10";
          };
        window = {
          background-color = mkLiteral "@background-color";
          border = 2;
          border-color = mkLiteral "@border-color";
          border-radius = 12;
          width = mkLiteral "600px";
        };
        mainbox = {
          background-color = mkLiteral "@background";
          border = 0;
        };
        message = {
          border-color = mkLiteral "@separator-color";
          border = mkLiteral "2px dash 0px 0px";
        };
        textbox = {
          background-color = mkLiteral "@background";
          text-color = mkLiteral "@foreground";
        };
        listview = {
          scrollbar = false;
          background-color = mkLiteral "@background-color";
          border = 0;
          border-radius = 0;
          fixed-height = 0;
          lines = 10;
        };
        element = {
          padding = mkLiteral "10px 10px 10px 25px";
          cursor = mkLiteral "pointer";
          border = 0;
        };
        "element normal.normal" = {
          background-color = mkLiteral "@background-color";
          text-color = mkLiteral "@foreground";
        };
        "element selected.normal" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@foreground";
        };
        "element alternate.normal" = {
          background-color = mkLiteral "@background-color";
          text-color = mkLiteral "@foreground";
        };
        "element-text" = {
          highlight = mkLiteral "@blue";
          text-color = mkLiteral "@foreground";
        };
        num-filtered-rows = { enabled = false; };
        num-rows = { enabled = false; };
        textbox-num-sep = { enabled = false; };
        inputbar = {
          padding = mkLiteral "20px 20px 10px 25px";
          spacing = mkLiteral "0px";
          text-color = mkLiteral "@foreground";
          background-color = mkLiteral "@black";
        };
        case-indicator = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
          enabled = false;
        };
        entry = {
          text-color = mkLiteral "@foreground";
          cursor = mkLiteral "text";
          spaceing = 0;
          placeholder-color = mkLiteral "@grey";
          placeholder = "  Search";
        };
        prompt = { enabled = false; };
        text-prompt-colon = { enabled = false; };
      };
  };
}
