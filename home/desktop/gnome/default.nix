{
  pkgs,
  config,
  ...
}: let
  inherit (config.theming) gtk icons cursors;
in {
  home = {
    packages = (
      with pkgs; [
        sushi
        loupe
        gnome-font-viewer
        gnome-usage
        gnome-music
        gnome-calculator
        gnome-disk-utility
        gnome-system-monitor
        gnome-calendar
        nautilus
        gnome-weather
        gnome-maps
        gnome-clocks
        papers
      ]
    );
  };

  xdg.mimeApps = let
    nautilus = "org.gnome.Nautilus.desktop";
    loupe = "org.gnome.Loupe.desktop";
    papers = "org.gnome.Papers.desktop";
  in {
    defaultApplications = {
      "application/pdf" = [papers];
      "inode/directory" = [nautilus];
      "image/bmp" = [loupe];
      "image/gif" = [loupe];
      "image/jpeg" = [loupe];
      "image/jpg" = [loupe];
      "image/pjpeg" = [loupe];
      "image/png" = [loupe];
      "image/tiff" = [loupe];
      "image/webp" = [loupe];
      "image/x-bmp" = [loupe];
      "image/x-gray" = [loupe];
      "image/x-icb" = [loupe];
      "image/x-ico" = [loupe];
      "image/x-png" = [loupe];
      "image/x-portable-anymap" = [loupe];
      "image/x-portable-bitmap" = [loupe];
      "image/x-portable-graymap" = [loupe];
      "image/x-portable-pixmap" = [loupe];
      "image/x-xbitmap" = [loupe];
      "image/x-xpixmap" = [loupe];
      "image/x-pcx" = [loupe];
      "image/svg+xml" = [loupe];
      "image/svg+xml-compressed" = [loupe];
      "image/vnd.wap.wbmp" = [loupe];
      "image/x-icns" = [loupe];
    };
  };

  theming = {
    gtk = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    icons = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
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
    '';
  in {
    enable = true;
    font = {
      name = "${config.theming.fonts.sans} 10";
    };
    theme = {inherit (gtk) name package;};
    cursorTheme = {inherit (cursors) name package;};
    iconTheme = {inherit (icons) name package;};
    gtk3.extraCss = colors;
    gtk4.extraCss = colors;
  };
}
