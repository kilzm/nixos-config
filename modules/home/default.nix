{
  pyprland = import ./pyprland;
  wallpaper = import ./wallpaper;
  theming = import ./theming;

  all = ({ ... }: { imports = [ ./pyprland ./wallpaper ./theming ]; });
}
