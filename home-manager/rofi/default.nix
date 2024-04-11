{ 
  lib,
  pkgs,
  cmn,
  config,
  ...
}:

{
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    font = "${cmn.font} 13";
    terminal = "kitty";
    plugins = with pkgs; [
      (rofi-calc.override {
        rofi-unwrapped = rofi-wayland-unwrapped;
      })
      rofi-power-menu
      (rofi-emoji.override {
        rofi-unwrapped = rofi-wayland-unwrapped;
      })
    ];
    theme = ./kanagawa2.rasi;
    # with config.colorScheme.colors; let
    #   lit = config.lib.formats.rasi.mkLiteral;
    #   background = lit "#${base00}";
    #   foreground = lit "#${base05}";
    #   highlight = lit "underline bold #${base03}";
    # in  {
    #   "*" = {
    #     background-color = background;
    #     foreground = foreground;
    #     highlight = highlight;
    #   };
    #   "window" = {
    #     location = lit "center";
    #     anchor = lit "center";
    #     padding = lit "10px";
    #     border = lit "0px";
    #     border-radius = lit "0px";
    #
    #     background-color = "#${base00}";
    #     spacing = 0;
    #     children =  [ (lit "mainbox") ];
    #     orientation =  lit "horizontal";
    #   };
    #   "mainbox" = {
    #     spacing = 0;
    #     children = map (x: lit x) [ "inputbar" "message" "listview" ];
    #   };
    #   "message" = {
    #     color = lit "#${base06}";
    #     padding = 5;
    #     border-color = foreground;
    #     border = lit "0px 2px 2px 2px";
    #     background-color = background;
    #   };
    #   "inputbar" = {
    #     color = foreground;
    #     padding = 5;
    #     background-color = background;
    #     border = lit "1px";
    #     border-color = foreground;
    #   };
    #   "entry, prompt, case-indicator" = {
    #     text-font = lit "inherit";
    #     text-color = lit "inherit";
    #   };
    #   "prompt" = {
    #     margin = lit "0px 1em 0em 0em";
    #   };
    #   "listview" = {
    #     padding = lit "8px";
    #     border-color = foreground;
    #     border = lit "0px 1px 1px 1px";
    #     background-color = background;
    #     dynamic = false;
    #   };
    #   "element" = {
    #     padding = lit "3px";
    #     vertical-align = lit "0.5";
    #     border-radius = lit "4px";
    #     background-color = background;
    #     color = foreground;
    #     text-color = foreground;
    #   };
    #   "element selected.normal" = {
    #     background-color = lit "#${base03}";
    #     text-color = foreground;
    #   };
    # };

    extraConfig = {
      modi = lib.concatStringsSep "," [
        "run"
        "drun"
        "emoji"
        "power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu"
      ];
      show-icons = true;
    };
  };
}
