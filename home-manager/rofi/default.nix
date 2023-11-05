{ 
  lib,
  pkgs,
  config,
  cmn,
  ...
}:

{
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    font = "${cmn.font} 15";
    terminal = "kitty";
    plugins = with pkgs; [
      rofi-calc
      rofi-power-menu
      rofi-emoji
    ];
    theme = ./nord.rasi;
    extraConfig = {
      modi = lib.concatStringsSep "," [
        "run"
        "drun"
        "calc"
        "emoji"
        "power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu"
      ];
      show-icons = true;
    };
  };
}
