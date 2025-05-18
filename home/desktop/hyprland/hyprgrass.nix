{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      pkgs.hyprlandPlugins.hyprgrass
    ];
    settings = {
      plugins.touch_gestures = {
        sensitivity = 4.0;
        workspace_swipe_fingers = 3;

        hyprgrass-bindm = [
          ", longpress:2, movewindow"
          ", longpress:3, resizewindow"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_cancel_ratio = 0.15;
      };
    };
  };
}
