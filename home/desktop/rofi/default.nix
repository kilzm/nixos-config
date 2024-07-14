{ lib, pkgs, config, ... }: {
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    font = "${config.theming.fonts.sans} 13";
    terminal = "foot";

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
        "@import" = "~/.cache/wal/colors-rofi-dark.rasi";
        "*" = {
          spacing = mkLiteral "10";
        };
        window = {
          border = 2;
          border-radius = 12;
          width = mkLiteral "600px";
        };
        mainbox = {
          border = 0;
        };
        message = {
          border = mkLiteral "2px dash 0px 0px";
        };
        listview = {
          scrollbar = false;
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
        num-filtered-rows = { enabled = false; };
        num-rows = { enabled = false; };
        textbox-num-sep = { enabled = false; };
        inputbar = {
          padding = mkLiteral "20px 20px 10px 25px";
          spacing = mkLiteral "0px";
        };
        case-indicator = {
          spacing = 0;
          enabled = false;
        };
        entry = {
          spaceing = 0;
        };
        prompt = { enabled = false; };
        text-prompt-colon = { enabled = false; };
      };
  };
}
