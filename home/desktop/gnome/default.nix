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
      accent-color = "slate";
    };
  };

  gtk = let
      bg = "#141414";
      fg = "#f0f0f0";
      bg2 = "#1a1a1a";
      border = "#292929";
    colors = ''
      @define-color window_bg_color ${bg};
      @define-color window_fg_color ${fg};
      @define-color view_bg_color ${bg};
      @define-color view_fg_color ${fg};
      @define-color thumbnail_bg_color ${bg};
      @define-color thumbnail_fg_color ${fg};
      @define-color headerbar_bg_color ${bg};
      @define-color headerbar_fg_color ${fg};
      @define-color headerbar_border_color ${border};
      @define-color headerbar_backdrop_color ${bg};
      @define-color headerbar_shade_color ${bg};
      @define-color card_bg_color ${bg};
      @define-color card_fg_color ${fg};
      @define-color card_shade_color ${bg};
      @define-color dialog_bg_color ${bg};
      @define-color dialog_fg_color ${fg};
      @define-color popover_bg_color ${bg};
      @define-color popover_fg_color ${fg};
      @define-color sidebar_bg_color ${bg2};
      @define-color sidebar_fg_color ${fg};
      @define-color sidebar_border_color ${border};
      @define-color sidebar_backdrop_color ${bg};
      @define-color sidebar_shade_color ${bg};
      @define-color shade_color ${bg};
      @define-color scrollbar_outline_color ${border};
    ''; in {
    enable = true;
    font = { name = "${config.theming.fonts.sans} 10"; };
    theme = { inherit (gtk) name package; };
    cursorTheme = { inherit (cursors) name package; };
    iconTheme = { inherit (icons) name package; };
    gtk3.extraCss = colors;
    gtk4.extraCss = colors;
  };
}
