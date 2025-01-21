{
  theming = import ./theming;
  pywal16 = import.pywal16;

  all = { ... }: { imports = [ ./theming ./pywal16 ]; };
}
