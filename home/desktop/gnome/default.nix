{ pkgs, config, ... }:
let
  inherit (config.theming) gtk icons cursors;
in
{
  home = {
    packages = (with pkgs; [
      glib
      eog
      sushi
      gnome-font-viewer
      gnome-calculator
      gnome-disk-utility
      gnome-system-monitor
      evince
      gnome-calendar
      nautilus
      gnome.gnome-weather
      gnome.gnome-maps
      gnome.gnome-clocks
    ]);
  };

  theming = {
    gtk = {
      name = "Colloid-Grey-Dark";
      package = (pkgs.colloid-gtk-theme.override {
        themeVariants = [ "grey" ];
        tweaks = [ "black" "normal" "rimless" ];
      });
    };
    icons = {
      name = "Colloid-grey-dark";
      package = (pkgs.colloid-icon-theme.override {
        colorVariants = [ "grey" ];
      });
    };
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
