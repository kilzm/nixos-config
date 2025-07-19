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
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    configDir = ./.;
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

  # home.packages = [
  #   ags-shell
  #   (inputs.ags.packages.${pkgs.system}.default.override {
  #     extraPackages = with inputs.ags.packages.${pkgs.system}; [
  #       apps
  #       battery
  #       bluetooth
  #       hyprland
  #       mpris
  #       network
  #       notifd
  #       tray
  #       wireplumber
  #     ];
  #   })
  # ];
}
