{ inputs, pkgs, ... }: {
  programs.pyprland = {
    enable = true;
    package = inputs.pyprland.packages.${pkgs.system}.pyprland;

    settings = {
      pyprland = { plugins = [ "scratchpads" "expose" "magnify" ]; };

      scratchpads = {
        term = {
          animation = "fromTop";
          command = "kitty --class scratchpad";
          margin = 200;
          size = "75% 60%";
        };
        yazi = {
          animation = "fromTop";
          command = "kitty --class scratchpad -e yazi";
          margin = 200;
          size = "75% 60%";
        };
        btop = {
          animation = "fromTop";
          command = "kitty --class scratchpad -e btop";
          margin = 200;
          size = "75% 60%";
        };
      };
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$shiftMod, Q, exec, pypr toggle term && hyprctl dispatch bringactivetotop"
        "$shiftMod, E, exec, pypr toggle yazi && hyprctl dispatch bringactivetotop"
        "$shiftMod, T, exec, pypr toggle btop && hyprctl dispatch bringactivetotop"
        "$mainMod, X, exec, pypr expose"
        "$mainMod, M, exec, pypr zoom"
        "$shiftMod, M, exec, pypr zoom ++0.5"
      ];

      workspace = [
        "special:exposed,gapsout:60,gapsin:30,bordersize:5,border:true,shadow:false"
      ];

      "$scratchpad" = "class:^(scratchpad)$";

      windowrulev2 = [
        "float, $scratchpad"
        "workspace special silent, $scratchpad"
        "center, $scratchpad"
      ];
    };
  };
}
