{ inputs, pkgs, ... }:

let
  fluctus-shell = inputs.ags.lib.bundle {
    inherit pkgs;
    src = ./.;
    name = "fluctus-shell";
    entry = "app.ts";
    gtk4 = true;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
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
in
{
  # home.packages = [
  #   fluctus-shell
  # ];
  imports = [ inputs.ags.homeManagerModules.default ];
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
}
