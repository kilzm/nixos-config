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
    theme = ./kanagawa.rasi;

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
