{ lib, inputs, pkgs }:

rec {
  colorScheme = inputs.nix-colors.colorSchemes.nord;
  wallpaper = ./wallpapers/city.png;
  font = "Iosevka Nerd Font";
  cursors = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    size = 24;
  };
  theme = {
    package = pkgs.adw-gtk3;
    name = "adw-gtk3";
  };
  icons = {
    package = pkgs.tela-icon-theme;
    name = "Tela-nord";
  };
  qt-theme = {
    package = pkgs.adwaita-qt;
    name = "adwaita-dark";
  };
}
