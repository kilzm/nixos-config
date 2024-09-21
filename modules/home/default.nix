{
  pyprland = import ./pyprland;
  theming = import ./theming;
  pywal16 = import.pywal16;

  all = { ... }: { imports = [ ./pyprland ./theming ./pywal16 ]; };
}
