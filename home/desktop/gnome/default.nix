{ pkgs, lib, host, config, self, ... }:
let
  wrapWithGTKTheme = pkg: name: theme:
    pkgs.stdenv.mkDerivation {
      inherit (pkg) version pname;
      nativeBuildInputs = [ pkgs.makeWrapper ];
      buildInputs = [ pkg ];
      src = pkg;
      installPhase = ''
        mkdir $out
        cp -r ./* $out
        wrapProgram $out/bin/${name} --set GTK_THEME ${theme}
      '';
    };

  inherit (config.theming) gtk icons cursors;

  nautilus-kanagawa = wrapWithGTKTheme pkgs.gnome.nautilus "nautilus" gtk.name;
  gnome-calendar-kanagawa =
    wrapWithGTKTheme pkgs.gnome.gnome-calendar "gnome-calendar" gtk.name;
in
{
  home = {
    packages = (with pkgs; [
      glib
      gnome.eog
      gnome.sushi
      gnome.gnome-font-viewer
      gnome.gnome-weather
      gnome.gnome-calculator
      gnome.gnome-maps
      gnome.gnome-disk-utility
      gnome.gnome-system-monitor
      evince
    ])
    ++ [ gnome-calendar-kanagawa nautilus-kanagawa ];
  };

  theming.gtk = {
    name = "Kanagawa-B";
    package = pkgs.kanagawa-gtk-theme;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      text-scaling-factor = lib.mkIf (host == "loid") 1.3;
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
