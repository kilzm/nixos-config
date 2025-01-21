{ pkgs, config, ... }: {
  theming.qt = {
    package = pkgs.adwaita-qt;
    name = "adwaita-dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = config.theming.qt;
  };
}
