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
      gnome-weather
      gnome-maps
      gnome-clocks
    ]);
  };

  xdg.mimeApps = {
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };
    associations.added = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

  theming = {
    gtk = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    icons = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
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
    gtk3.extraCss = ''
      headerbar, .titlebar,
      .csd:not(.popup):not(tooltip):not(messagedialog) decoration{
        border-radius: 0;
      }
    '';
    gtk4.extraCss = ''
      window.messagedialog .response-area > button,
      window.dialog.message .dialog-action-area > button,
      .background.csd{
        border-radius: 0;
      }
    '';
  };

  # home.file.".config/gtk-4.0/gtk.css"
}
