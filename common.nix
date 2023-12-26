{ lib, inputs, pkgs }:
let
  colorSchemes = {
    nord = rec {
      name = "nord";
      kitty = "Nord";
      spicetify = "nord-dark";
      base16 = inputs.nix-colors.colorSchemes.nord;
      gtk3 = "${inputs.nordic-gtk}/gtk-3.0/gtk-dark.css";
      gtk4 = "${inputs.nordic-gtk}/gtk-4.0/gtk-dark.css";
      wallpaper = ./wallpapers/ahsoka.png;
      ram = "0354d7";
    };
    kanagawa = rec {
      name = "kanagawa";
      kitty = "kanagawabones";
      spicetify = "Kanagawa";
      base16 = inputs.nix-colors.colorSchemes.kanagawa;
      gtk3 = "${inputs.kanagawa-gtk}/themes/Kanagawa-B/gtk-3.0";
      gtk4 = "${inputs.kanagawa-gtk}/themes/Kanagawa-B/gtk-4.0";
      wallpaper = ./wallpapers/pine-mountains.jpg;
      wallpaper-flipped = ./wallpapers/pine-mountains-flipped.jpg;
      ram = "3232fd";
    };
  };
in rec {
  scheme = colorSchemes.kanagawa;
  font = "Iosevka Nerd Font";
  cursors = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors"; size = 24;
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
