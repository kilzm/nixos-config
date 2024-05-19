{
  pkgs,
  config,
  cmn,
  inputs,
  host,
  ...
}:
let

  inherit (cmn) scheme;
  wallpaper = scheme.wallpaper;
  wallpaper-flipped = scheme.wallpaper-flipped or wallpaper;

  c = config.colorScheme.palette;
in
{
  imports = [
    ./${host}.nix
  ];

  home.packages = with pkgs; [
    hyprpicker
    hyprshot
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      general = {
        gaps_in = 8;
        gaps_out = 16;
        border_size = 3;
        "col.active_border" = "rgba(${c.base03}FF)";
        "col.inactive_border" = "rgba(${c.base00}FF)";
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
          size = 6;
          passes = 3;
        };
        drop_shadow = false;
      };

      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0, 0, 0, 0"
        ];
        animation = [
          "windows, 1, 2, myBezier, slide"
          "windowsOut, 1, 2, myBezier"
          "fade, 1, 2, myBezier"
          "workspaces, 1, 2, myBezier"
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
        "$mainMod, S, exec, spotify"
        "$mainMod, D, exec, webcord"
        "$mainMod, Escape, exec, rofi -show \"power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu --choices=shutdown/reboot/suspend/logout\""
        "$mainMod, bracketleft, exec, clipman pick -t rofi"
        "$mainMod, bracketright, exec, hyprpicker -a"
        "$mainMod, Z, exec, hyprlock"
        "$mainMod, P, exec, HYPRSHOT_DIR=~/Pictures hyprshot -m window"
        "$shiftMod, P, exec, HYPRSHOT_DIR=~/Picutres hyprshot -m region"

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
      
      windowrule = [
        "center, classic:idea-community"
      ];

      env = [
        "XCURSOR_THEME, ${cmn.cursors.name}"
        "XCURSOR_SIZE, ${builtins.toString cmn.cursors.size}"
        "HYPRSHOT_DIR, ~/Pictures/"
      ];

      misc = {
        disable_hyprland_logo = true;
      };

      exec-once = [
        "waybar"
        "dunst"
        "hypridle"
        "hyprpaper"
        "nm-applet --indicator"
        "blueman-applet"
        ''hyprctl dispatch exec "[workspace 9 silent]" spotify''
        ''wl-paste -t text --watch clipman store -P --histpath="~/.local/share/clipman-primary.json"''
      ];
    };
  };

  services.clipman = {
    enable = true;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        "${wallpaper}"
        "${wallpaper-flipped}"
      ];
    };
  };

  programs.hyprlock = 
  let
    inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
    hexToRGB = hexToRGBString ", ";
  in {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = "${wallpaper}";
          blur_passes = 2;
          blur_size = 7;

          contrast = 0.8;
          brightness = 0.8;
          vibrancy = 0.2;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -120";
          halign = "center";
          valign = "center";
          font_color = "rgb(${hexToRGB c.base03})";
          inner_color = "rgba(${hexToRGB c.base01}, 0.8)";
          outer_color = "rgba(${hexToRGB c.base01}, 0.8)";
          check_color = "rgb(${hexToRGB c.base06})";
          fail_color = "rgb(${hexToRGB c.base08})";
          font_family = "${cmn.font}";
        }
      ];

      label = [
        {
          text = ''cmd[update:1000] echo "$(date +"%R")"'';
          color = "rgba(${hexToRGB c.base01}, 0.8)";
          font_size = 120;
          position = "0, -300";
          halign = "center";
          valign = "top";
          font_family = "${cmn.font} Bold";
        }
        {
          text = "Servus, Kilian";
          color = "rgba(${hexToRGB c.base01}, 0.8)";
          font_size = 25;
          position = "0, -40";
          halign = "center";
          valign = "center";
          font_family = "${cmn.font} SemiBold";
        }
      ];
    };
  };
}
