{ inputs, pkgs, config, host, ... }:
{
  imports = [
    ./${host}.nix
    ./pyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [ hyprpicker grimblast ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
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

      general = {
        gaps_in = 9;
        gaps_out = 18;
        border_size = 1;
        "col.active_border" = "rgba(252525ff)";
        "col.inactive_border" = "$background";
        layout = "dwindle";
      };

      input = {
        kb_layout = "us, us(altgr-intl), de";
        kb_variant = "nodeadkeys";
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
        rounding = 18;
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          color = "0x55000000";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "linear, 1, 1, 1, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 7, wind, popin 80%"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, linear"
          "fade, 1, 3, default"
          "workspaces, 1, 5, wind"
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
        "$mainMod, Q, exec, foot"
        "$mainMod, Return, exec, foot"
        "$mainMod, C, killactive"
        "$mainMod, F, fullscreen"
        "$mainMod, E, exec, nautilus -w"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, ags -t launcher"
        "$shiftMod, Return, exec, ags -t launcher"
        "$mainMod, T, togglesplit"
        "$mainMod, B, exec, zen"
        "$mainMod, D, exec, vesktop"
        "$mainMod, Escape, exec, ags -t powermenu"
        "$mainMod, bracketleft, exec, clipman pick -t rofi"
        "$mainMod, bracketright, exec, hyprpicker -a"
        "$mainMod, Z, exec, hyprlock"
        "$mainMod, P, exec, grimblast --notify --freeze copy area"
        "$shiftMod, P, exec, grimblast --notify --freeze copysave area"
        "$ctrlMod, P, exec, grimblast --notify copy output"
        "$shiftMod CTRL, P, exec, grimblast --notify copysave output"

        "$mainMod, Tab, exec, ags -t overview"

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
      ];

      windowrule = [ "center, classic:idea-community" ];

      windowrulev2 = [
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
        "swww-daemon"
        "ags &"
        ''
          wl-paste -t text --watch clipman store -P --histpath="~/.local/share/clipman-primary.json"''
      ];
    };
  };

  services.clipman = { enable = true; };
}
