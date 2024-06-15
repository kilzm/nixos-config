{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.default
    ];
    settings = {
      plugins.touch_gestures = {
        sensitivity = 4.0;
        workspace_swipe_fingers = 3;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_cancel_ratio = 0.15;
      };
    };
  };
}

