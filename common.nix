{ lib, inputs, pkgs }:
let
  colorSchemes = {
    kanagawa = {
      name = "kanagawa";
      kitty = "kanagawabones";
      spicetify = "Kanagawa";
      base16 = inputs.nix-colors.colorSchemes.kanagawa;
      gtk3 = "${inputs.kanagawa-gtk}/themes/Kanagawa-B/gtk-3.0";
      gtk4 = "${inputs.kanagawa-gtk}/themes/Kanagawa-B/gtk-4.0";
      wallpaper = ./wallpapers/pine-mountains.png;
      wallpaper-flipped = ./wallpapers/pine-mountains-flipped.png;
      ram = "2832ff";
    };
  };
in {
  scheme = colorSchemes.kanagawa;
  font = "Iosevka Nerd Font";
  cursors = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 16;
  };
  theme = {
    package = pkgs.kilzm.kanagawa-gtk;
    name = "Kanagawa-B";
  };
  icons = {
    package = pkgs.whitesur-icon-theme;
    name = "WhiteSur-dark";
  };
  qt-theme = {
    package = pkgs.adwaita-qt;
    name = "adwaita-dark";
  };
}
