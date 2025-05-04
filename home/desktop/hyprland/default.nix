{ inputs, pkgs, config, host, ... }:
{
  imports = [
    ./${host}.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./scratchpads.nix
  ];

  home.packages = with pkgs; [ hyprpicker grimblast hyprsunset ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    xwayland = {
      enable = true;
    };

    plugins = with pkgs.hyprlandPlugins; [
    ];

    settings = {
      source = "~/.cache/wal/colors-hyprland.conf";
      
      "$terminal" = "ghostty";
      "$fileManager" = "nautilus";

      general = {
        gaps_in = 10;
        gaps_out = 20;
        border_size = 1;
        "col.active_border" = "rgba(252525ff)";
        "col.inactive_border" = "$background";
        layout = "dwindle";
      };

      input = {
        kb_layout = "us, us(altgr-intl), de";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.3;
          drag_lock = true;
          tap-to-click = true;
          tap-and-drag = true;
        };
      };

      decoration = {
        rounding = 12;
        inactive_opacity = 0.98;
        shadow = {
          enabled = false;
          range = 20;
          render_power = 3;
          color = "0x55000000";
        };
        blur = {
          enabled = true;
          ignore_opacity = true;
          size = 16;
          passes = 3;
          noise = 0.05;
          contrast = 0.9;
          brightness = 1.0;
          popups = true;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "decel, 0.05, 0.7, 0.1, 1.0"
          "accel, 0.3, 0, 0.9, 0.15"
        ];

        animation = [
          # "windows, 1, 5, decel, popin 60%"
          "windows, 1, 5, decel"
          "windowsIn, 1, 5, decel, gnomed"
          "windowsOut, 1, 7, decel, gnomed"
          "border, 1, 1, linear"
          "fade, 1, 3, decel"
          "workspaces, 1, 6, decel, slidefade"
          "specialWorkspace, 1, 6, decel, slidefadevert -50%"
          "layers, 1, 4, decel, slide"
          "layersIn, 1, 5, decel, slide"
          "layersOut, 1, 4, accel"
          "fadeLayersIn, 1, 3, decel"
          "fadeLayersOut, 1, 3, accel"
        ];
      };

      dwindle = {
        force_split = 0;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = true;
        preserve_split = true;
      };

      "$mainMod" = "SUPER";
      "$shiftMod" = "SUPERSHIFT";
      "$ctrlMod" = "SUPERCTRL";

      bind = [
        "$mainMod, Q, exec, ghostty"
        "$mainMod, Return, exec, ghostty"
        "$mainMod, C, killactive"
        "$mainMod, F, fullscreen"
        "$mainMod, E, exec, nautilus -w"
        "$mainMod, V, togglefloating"
        ''$mainMod, R, exec, ags request "toggle applauncher"''
        ''$shiftMod, Return, exec, ags request "toggle applauncher"''
        "$mainMod, T, togglesplit"
        "$mainMod, B, exec, zen"
        "$mainMod, D, exec, vesktop"
        ''$mainMod, Escape, exec, ags request "toggle powermenu"''
        "$mainMod, bracketleft, exec, clipman pick -t rofi"
        "$mainMod, bracketright, exec, hyprpicker -a"
        "$mainMod, Z, exec, hyprlock"
        "$mainMod, P, exec, grimblast --notify --freeze copy area"
        "$shiftMod, P, exec, grimblast --notify --freeze copysave area"
        "$ctrlMod, P, exec, grimblast --notify copy output"
        "$shiftMod CTRL, P, exec, grimblast --notify copysave output"

        "$ctrlMod, S, movetoworkspace, special"
        "$mainMod, S, togglespecialworkspace"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        "$shiftMod, H, resizeactive, -30 0"
        "$shiftMod, L, resizeactive, 30 0"
        "$shiftMod, K, resizeactive, 0 -30"
        "$shiftMod, J, resizeactive, 0 30"

        "$ctrlMod, H, movewindow, l"
        "$ctrlMod, L, movewindow, r"
        "$ctrlMod, K, movewindow, u"
        "$ctrlMod, J, movewindow, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$shiftMod, 1, movetoworkspace, 1"
        "$shiftMod, 2, movetoworkspace, 2"
        "$shiftMod, 3, movetoworkspace, 3"
        "$shiftMod, 4, movetoworkspace, 4"
        "$shiftMod, 5, movetoworkspace, 5"
        "$shiftMod, 6, movetoworkspace, 6"
        "$shiftMod, 7, movetoworkspace, 7"
        "$shiftMod, 8, movetoworkspace, 8"
        "$shiftMod, 9, movetoworkspace, 9"
        "$shiftMod, 0, movetoworkspace, 10"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, equal, exec, hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 + 0.5}')"
        "$mainMod, minus, exec, hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 - 0.5}')" 
        "$mainMod, backspace, exec, hyprctl keyword cursor:zoom_factor 1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ", XF86MonBrightnessUp,exec,brightnessctl set +5%"
        "CTRL, XF86AudioLowerVolume, exec, hyprctl hyprsunset temperature -500"
        "CTRL, XF86AudioRaiseVolume, exec, hyprctl hyprsunset temperature +500"
        "CTRL, XF86AudioMute, exec, hyprctl hyprsunset identity"
      ];

      layerrule = [
        "animation popin 30%, powermenu"
        "animation popin 30%, verification"
        "animation slide down, applauncher"
        "animation slide up, osd"
        "animation slide down, calendar"
        "animation slide down, quicksettings"
        "animation slide down, notification"

        "dimaround, powermenu"
        "dimaround, verification"
        "dimaround, verification"

        "blur, bar"
        "blur, applauncher"
        "blur, powermenu"
        "blur, verification"
        "blur, osd"
        "blur, calendar"
        "blur, quicksettings"
        "blur, notification"

        "ignorealpha [0.8], bar"
        "ignorealpha [0.8], applauncher"
        "ignorealpha [0.8], powermenu"
        "ignorealpha [0.8], verification"
        "ignorealpha [0.8], osd"
        "ignorealpha [0.8], calendar"
        "ignorealpha [0.8], quicksettings"
        "ignorealpha [0.8], notification"
      ];

      windowrule = [
        "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
        "float, class:^(vlc)$"

        "float, class:blueman-"
        "float, class:^nm-"
      ];

      env =
        [ "XCURSOR_THEME, ${config.theming.cursors.name}" "XCURSOR_SIZE, 16" ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      exec-once = [
        "hyprsunset"
        "swww-daemon"
        "ags run --gtk4"
        ''wl-paste -t text --watch clipman store -P --histpath="~/.local/share/clipman-primary.json"''
      ];
    };
  };

  services.clipman = { enable = true; };
}
