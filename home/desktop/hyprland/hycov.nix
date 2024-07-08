{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hycov.packages.${pkgs.system}.hycov
    ];

    settings = {
      bind = [
        "bind=$mainMod,Tab,hycov:toggleoverview"
      ];

      plugin = {
        hycov = {
          overview_gappo = 60;
          overview_gappi = 24;
          enable_hotarea = 0;
        };
      };
    };
  };
}
