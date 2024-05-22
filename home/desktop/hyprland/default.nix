{ pkgs, config, inputs, host, ... }:
let c = config.colorScheme.palette;
in {
  imports = [
    ./${host}.nix
    ./pyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  nixpkgs.overlays = [ inputs.hyprpicker.overlays.default ];

  home.packages = with pkgs; [ hyprpicker grimblast ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      general = {
        gaps_in = 8;
        gaps_out = 16;
        border_size = 3;
        "col.active_border" = "rgb(${c.base03})";
        "col.inactive_border" = "rgb(${c.base00})";
        layout = "dwindle";
      };

      input = {
        kb_layout = "us, us(altgr-intl), de";
        kb_variant = "nodeadkeys";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.3;
        };
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          popups = true;
        };
        drop_shadow = false;
      };

      animations = {
        enabled = true;
        animation = [
          "windows, 1, 2, default, slide"
          "windowsOut, 1, 2, default"
          "fade, 1, 2, default"
          "workspaces, 1, 2, default"
        ];
      };

      dwindle = {
        no_gaps_when_only = false;
        force_split = 0;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
        special_scale_factor = 0.8;
        no_gaps_when_only = false;
      };

      "$mainMod" = "SUPER";
      "$shiftMod" = "SUPERSHIFT";
      "$ctrlMod" = "SUPERCTRL";

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive"
        "$mainMod, F, fullscreen"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, rofi -show drun -show-icons"
        "$mainMod, T, togglesplit"
        "$mainMod, A, exec, rofi -show calc -no-show-match -no-sort"
        "$mainMod, B, exec, firefox"
        "$mainMod, D, exec, webcord"
        ''
          $mainMod, Escape, exec, rofi -show "power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu --choices=shutdown/reboot/suspend/logout"''
        "$mainMod, bracketleft, exec, clipman pick -t rofi"
        "$mainMod, bracketright, exec, hyprpicker -a"
        "$mainMod, Z, exec, hyprlock"
        "$mainMod, P, exec, grimblast --notify --freeze copy area"
        "$shiftMod, P, exec, grimblast --notify --freeze copysave area"

        "$shiftMod, S, movetoworkspace, special"
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

      env =
        [ "XCURSOR_THEME, ${config.theming.cursors.name}" "XCURSOR_SIZE, 16" ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      exec-once = [
        "waybar"
        "dunst"
        "nm-applet --indicator"
        "blueman-applet"
        ''hyprctl dispatch exec "[workspace 9 silent]" spotify''
        ''
          wl-paste -t text --watch clipman store -P --histpath="~/.local/share/clipman-primary.json"''
      ];
    };
  };

  services.clipman = { enable = true; };
}
