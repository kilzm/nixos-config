{
  inputs,
  pkgs,
  config,
  lib,
  cmn,
  ...
}:
let
  wallpaper = cmn.wallpaper;
  kb-icon = ./icons/kb.png;
  switch-layout = pkgs.writeShellScriptBin "switch-layout" ''
    keyboard="keychron-keychron-q8-keyboard"
    hyprctl switchxkblayout $keyboard next
    value=$(hyprctl devices | grep -i "$keyboard" -A 2 | tail -n1 | cut -d ' ' -f3-)
    notify-send -t 1800 -i ${kb-icon} "$value" "Changed keyboard layout to: $value"
  '';
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    hyprctl hyprpaper wallpaper "DP-2,${wallpaper}"
    hyprctl hyprpaper wallpaper "DP-4,${wallpaper}"
    hyprctl hyprpaper wallpaper "DP-5,${wallpaper}"
    hyprctl hyprpaper wallpaper "DP-7,${wallpaper}"
  '';
in

{
  wayland.windowManager.hyprland =
  {
    enable = true;
    systemd.enable = true;
    extraConfig = let 
      c = config.colorScheme.colors;
    in ''
      env = XCURSOR_SIZE,2

      monitor = DP-4,1920x1200@60,0x0,1
      monitor = DP-5,1920x1200@60,0x0,1
      monitor = DP-7,1920x1200@60,0x0,1
      monitor = DP-2,2560x1440@165,1920x0,1

      input {
        kb_layout = us, us(altgr-intl), de
        kb_variant = nodeadkeys
        follow_mouse = 1
      }

      general {
        gaps_in = 10
        gaps_out = 22
        border_size = 3
        col.active_border = rgba(${c.base0D}FF) rgba(${c.base04}FF) 45deg
        col.inactive_border = rgba(${c.base03}FF)
        layout = dwindle
      }

      decoration {
        rounding = 0
        blur {
          enabled = true
          size = 6
          passes = 1
        }
      }

      animations {
        enabled = yes
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }

      dwindle {
        pseudotile = yes
        preserve_split = yes
      }

      master {
        new_is_master = true
      }

      $mainMod = SUPER

      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, C, killactive
      bind = $mainMod, F, fullscreen
      bind = $mainMod, E, exec, nautilus
      bind = $mainMod, V, togglefloating
      bind = $mainMod, R, exec, rofi -show drun -show-icons
      bind = $mainMod, P, pseudo # dwindle
      bind = $mainMod, J, togglesplit # dwindle
      bind = $mainMod, T, exec, rofi -show calc, -no-show-match -no-sort
      bind = $mainMod, W, exec, ${set-wallpaper}/bin/set-wallpaper
      bind = $mainMod, B, exec, firefox
      bind = $mainMod, S, exec, spotify
      bind = $mainMod, D, exec, discord
      bind = $mainMod, space, exec, ${switch-layout}/bin/switch-layout
      bind = $mainMod, Escape, exec, rofi -show "power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu --choices=shutdown/reboot/suspend/logout"

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow


      binde=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+
      binde=, XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-
      binde=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle


      exec-once = hyprctl setcursor ${cmn.cursors.name} ${builtins.toString cmn.cursors.size}
      exec-once = waybar
      exec-once = dunst 
      exec-once = nm-applet --indicator
      exec-once = hyprctl dispatch exec "[workspace 4 silent]" spotify
      exec-once = hyprpaper
      exec-once = ${set-wallpaper}/bin/set-wallpaper
    '';

  };

  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = "preload = ${wallpaper}";
}
