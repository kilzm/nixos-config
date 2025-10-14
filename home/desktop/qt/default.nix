{
  pkgs,
  config,
  ...
}: {
  theming.qt = {
    package = pkgs.adwaita-qt;
    name = "Adwaita-dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "Adwaita-dark";
    style = config.theming.qt;
  };

  home.packages = with pkgs; [
    kdePackages.qtdeclarative
  ];
}
