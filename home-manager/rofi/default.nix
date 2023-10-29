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
    font = "UbuntuMono Nerd Font 14";
    terminal = "kitty";
    plugins = [ pkgs.rofi-calc ];
    theme = ./nord.rasi;
  };
}