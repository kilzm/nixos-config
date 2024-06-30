{ pkgs, config, ... }: {
  theming.qt = {
    package = pkgs.adwaita-qt;
    name = "adwaita-gtk";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = config.theming.qt;
  };
}
