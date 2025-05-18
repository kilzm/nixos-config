{
  inputs,
  pkgs,
  ...
}: let
  ags-shell = inputs.ags.lib.bundle {
    inherit pkgs;
    src = ./.;
    name = "ags-shell";
    entry = "app.ts";
    gtk4 = true;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      apps
      battery
      bluetooth
      hyprland
      mpris
      network
      notifd
      tray
      wireplumber
    ];
  };
in {
  home.packages = [
    ags-shell
    inputs.ags.packages.${pkgs.system}.ags
  ];
}
