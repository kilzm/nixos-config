{
  pyprland = import ./pyprland;
  wallpaper = import ./wallpaper;
  theming = import ./theming;
  pywal16 = import.pywal16;

  all = { ... }: { imports = [ ./pyprland ./wallpaper ./theming ./pywal16 ]; };
}
