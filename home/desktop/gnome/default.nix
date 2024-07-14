{ pkgs, lib, host, config, self, ... }:
let
  inherit (config.theming) gtk icons cursors;
in
{
  home = {
    packages = (with pkgs; [
      glib
      eog
      sushi
      gnome.gnome-weather
      gnome.gnome-maps
      gnome-font-viewer
      gnome-calculator
      gnome-disk-utility
      gnome-system-monitor
      evince
      gnome-calendar
      nautilus
    ]);
  };

  theming.gtk = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      scaling-factor = 0;
      color-scheme = "prefer-dark";
      gtk-theme = gtk.name;
      cursor-theme = cursors.name;
      icon-theme = icons.name;
    };
  };

  gtk = {
    enable = true;
    font = { name = "${config.theming.fonts.sans} 10"; };
    theme = { inherit (gtk) name package; };
    cursorTheme = { inherit (cursors) name package; };
    iconTheme = { inherit (icons) name package; };
  };
}
