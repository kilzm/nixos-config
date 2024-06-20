{ inputs, pkgs, ... }: {
  programs.pyprland = {
    enable = true;
    package = inputs.pyprland.packages.${pkgs.system}.pyprland;

    settings = {
      pyprland = { plugins = [ "scratchpads" ]; };

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
        qalc = {
          animation = "fromTop";
          command = "kitty --class scratchpad -e qalc";
          margin = 200;
          size = "75% 60%";
        };
        pavucontrol = {
          animation = "fromTop";
          command = "pavucontrol";
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
        "$shiftMod, C, exec, pypr toggle qalc && hyprctl dispatch bringactivetotop"
        "$shiftMod, A, exec, pypr toggle pavucontrol && hyprctl dispatch bringactivetotop"
      ];

      "$scratchpad" = "class:^(scratchpad)$";
      "$pavucontrol" = "class:^(pavucontrol)$";

      windowrulev2 = [
        "float, $scratchpad"
        "workspace special silent, $scratchpad"
        "center, $scratchpad"

        "float, $pavucontrol"
        "workspace special silent, $pavucontrol"
        "center, $pavucontrol"
      ];
    };
  };
}
