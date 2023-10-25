{ 
  lib,
  pkgs,
  config,
  ...
}:

{
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    font = "GohuFont 11 Nerd Font Mono 14";
    terminal = "kitty";
    plugins = [ pkgs.rofi-calc ];
    theme = ./apps/rofi/nord.rasi;
  };
}