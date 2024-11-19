{ inputs, pkgs, ... }: {
  programs.pyprland = {
    enable = true;
    package = inputs.stable.legacyPackages.${pkgs.system}.pyprland;

    settings = {
      pyprland = { plugins = [ "scratchpads" ]; };

      scratchpads = {
        term = {
          class = "scratchpad";
          lazy = true;
          animation = "fromTop";
          command = "foot --app-id scratchpad";
          margin = 200;
          size = "85% 70%";
        };
        yazi = {
          class = "scratchpad";
          lazy = true;
          animation = "fromTop";
          command = "foot --app-id scratchpad yazi";
          margin = 200;
          size = "85% 70%";
        };
        btop = {
          class = "scratchpad";
          lazy = true;
          animation = "fromTop";
          command = "foot --app-id scratchpad btop";
          margin = 200;
          size = "85% 70%";
        };
        qalc = {
          class = "scratchpad";
          lazy = true;
          animation = "fromTop";
          command = "foot --app-id scratchpad qalc";
          margin = 200;
          size = "85% 70%";
        };
        pavucontrol = {
          lazy = true;
          animation = "fromTop";
          command = "pavucontrol";
          margin = 200;
          size = "85% 70%";
        };
        blueman = {
          lazy = true;
          animation = "fromTop";
          command = "blueman-manager";
          margin = 200;
          size = "85% 70%";
        };
        nm = {
          lazy = true;
          animation = "fromTop";
          command = "nm-connection-editor";
          margin = 200;
          size = "85% 70%";
        };
        waypaper = {
          lazy = true;
          class = "waypaper";
          animation = "fromTop";
          command = "waypaper";
          margin = 200;
          size = "85% 70%";
        };
        spotify = {
          animation = "fromTop";
          command = "spotify";
          margin = 200;
          size = "85% 70%";
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
        "$shiftMod, S, exec, pypr toggle spotify && hyprctl dispatch bringactivetotop"
      ];

      "$pavucontrol" = "class:pavucontrol";
      "$waypaper" = "class:^(waypaper)$";
      "$spotify" = "title:Spotify";

      windowrulev2 = [
        "float, $pavucontrol"
        "workspace special silent, $pavucontrol"
        "center, $pavucontrol"

        "float, $spotify"
        "workspace special silent, $spotify"
        "center, $spotify"

        "float, $waypaper"
        "workspace special silent, $waypaper"
        "center, $waypaper"
      ];
    };
  };
}
