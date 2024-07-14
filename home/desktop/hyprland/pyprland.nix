{ inputs, pkgs, ... }: {
  programs.pyprland = {
    enable = true;
    package = inputs.pyprland.packages.${pkgs.system}.pyprland;

    settings = {
      pyprland = { plugins = [ "scratchpads" ]; };

      scratchpads = {
        term = {
          lazy = true;
          animation = "fromTop";
          command = "foot --app-id scratchpad";
          margin = 200;
          size = "75% 60%";
        };
        yazi = {
          lazy = true;
          animation = "fromTop";
          command = "foot --app-id scratchpad yazi";
          margin = 200;
          size = "75% 60%";
        };
        btop = {
          lazy = true;
          animation = "fromTop";
          command = "foot --app-id scratchpad btop";
          margin = 200;
          size = "75% 60%";
        };
        qalc = {
          lazy = true;
          animation = "fromTop";
          command = "foot --app-id scratchpad qalc";
          margin = 200;
          size = "75% 60%";
        };
        pavucontrol = {
          lazy = true;
          animation = "fromTop";
          command = "pavucontrol";
          margin = 200;
          size = "75% 60%";
        };
        blueman = {
          lazy = true;
          animation = "fromTop";
          command = "blueman-manager";
          margin = 200;
          size = "75% 60%";
        };
        nm = {
          lazy = true;
          animation = "fromTop";
          command = "nm-connection-editor";
          margin = 200;
          size = "75% 60%";
        };
        waypaper = {
          animation = "fromTop";
          command = "waypaper";
          margin = 200;
          size = "45% 60%";
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
        "$shiftMod, B, exec, pypr toggle blueman && hyprctl dispatch bringactivetotop"
        "$shiftMod, N, exec, pypr toggle nm && hyprctl dispatch bringactivetotop"
        "$shiftMod, W, exec, pypr toggle waypaper && hyprctl dispatch bringactivetotop"
      ];

      "$scratchpad" = "class:scratchpad";
      "$pavucontrol" = "class:^(pavucontrol)$";
      "$waypaper" = "class:waypaper";

      windowrulev2 = [
        "float, $scratchpad"
        "workspace special silent, $scratchpad"
        "center, $scratchpad"

        "float, $pavucontrol"
        "workspace special silent, $pavucontrol"
        "center, $pavucontrol"

        "float, $waypaper"
        "workspace special silent, $waypaper"
        "center, $waypaper"
      ];
    };
  };
}
