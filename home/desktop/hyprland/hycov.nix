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
          hotarea_size = 10;
          enable_hotarea = 1;
          swipe_fingers = 4;
          enable_gesture = 1;
        };
      };
    };
  };
}
