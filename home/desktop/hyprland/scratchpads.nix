{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        ''$shiftMod, Q, exec, if hyprctl clients | grep "scratch\.term"; then echo "scratch.term respawn not needed"; else ghostty --class=scratch.term; fi''
        "$shiftMod, Q, togglespecialworkspace, scratch_term"

        ''$shiftMod, E, exec, if hyprctl clients | grep "scratch\.yazi"; then echo "scratch.yazi respawn not needed"; else ghostty --class=scratch.yazi -e yazi; fi''
        "$shiftMod, E, togglespecialworkspace, scratch_yazi"

        ''$shiftMod, T, exec, if hyprctl clients | grep "scratch\.btop"; then echo "scratch.btop respawn not needed"; else ghostty --class=scratch.btop -e btop; fi''
        "$shiftMod, T, togglespecialworkspace, scratch_btop"

        ''$shiftMod, C, exec, if hyprctl clients | grep "scratch\.qalc"; then echo "scratch.qalc respawn not needed"; else ghostty --class=scratch.qalc -e qalc; fi''
        "$shiftMod, C, togglespecialworkspace, scratch_qalc"

        ''$shiftMod, A, exec, if hyprctl clients | grep "pwvucontrol"; then echo "pwvucontrol respawn not needed"; else pwvucontrol; fi''
        "$shiftMod, A, togglespecialworkspace, scratch_pwvucontrol"

        ''$shiftMod, B, exec, if hyprctl clients | grep "blueman"; then echo "blueman respawn not needed"; else blueman; fi''
        "$shiftMod, B, togglespecialworkspace, scratch_blueman"

        ''$shiftMod, W, exec, if hyprctl clients | grep "waypaper"; then echo "waypaper respawn not needed"; else waypaper; fi''
        "$shiftMod, W, togglespecialworkspace, scratch_waypaper"

        ''$shiftMod, S, exec, if hyprctl clients | grep "spotify"; then echo "spotify respawn not needed"; else spotify; fi''
        "$shiftMod, S, togglespecialworkspace, scratch_spotify"

        ''$shiftMod, N, exec, if hyprctl clients | grep "nm-connection-editor"; then echo "nm-connection-editor respawn not needed"; else nm-connection-editor; fi''
        "$shiftMod, N, togglespecialworkspace, scratch_networkmanager"
      ];

      "$scratchpadsize" = "size 80% 80%";
      "$scratch_term" = "class:^(scratch.term)$";
      "$scratch_yazi" = "class:^(scratch.yazi)$";
      "$scratch_btop" = "class:^(scratch.btop)$";
      "$scratch_qalc" = "class:^(scratch.qalc)$";
      "$scratch_waypaper" = "class:^(waypaper)$";
      "$scratch_spotify" = "class:^(spotify)$";
      "$scratch_networkmanager" = "class:^(nm-connection-editor)$";
      "$scratch_pwvucontrol" = "class:^(com.saivert.pwvucontrol)$";
      "$scratch_blueman" = "class:^(.blueman-manager-wrapped)$";

      windowrulev2 = [
        "float, $scratch_term"
        "$scratchpadsize, $scratch_term"
        "workspace special:scratch_term, $scratch_term"
        "center, $scratch_term"

        "float, $scratch_yazi"
        "$scratchpadsize, $scratch_yazi"
        "workspace special:scratch_yazi, $scratch_yazi"
        "center, $scratch_yazi"

        "float, $scratch_btop"
        "$scratchpadsize, $scratch_btop"
        "workspace special:scratch_btop, $scratch_btop"
        "center, $scratch_btop"

        "float, $scratch_qalc"
        "$scratchpadsize, $scratch_qalc"
        "workspace special:scratch_qalc, $scratch_qalc"
        "center, $scratch_qalc"

        "float, $scratch_pwvucontrol"
        "$scratchpadsize, $scratch_pwvucontrol"
        "workspace special:scratch_pwvucontrol, $scratch_pwvucontrol"
        "center, $scratch_pwvucontrol"

        "float, $scratch_blueman"
        "$scratchpadsize, $scratch_blueman"
        "workspace special:scratch_blueman, $scratch_blueman"
        "center, $scratch_blueman"

        "float, $scratch_waypaper"
        "$scratchpadsize, $scratch_waypaper"
        "workspace special:scratch_waypaper, $scratch_waypaper"
        "center, $scratch_waypaper"

        "float, $scratch_spotify"
        "$scratchpadsize, $scratch_spotify"
        "workspace special:scratch_spotify, $scratch_spotify"
        "center, $scratch_spotify"

        "float, $scratch_networkmanager"
        "$scratchpadsize, $scratch_networkmanager"
        "workspace special:scratch_networkmanager, $scratch_networkmanager"
        "center, $scratch_networkmanager"
      ];
    };
  };
}
