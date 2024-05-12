{
  pkgs,
  config,
  cmn,
  inputs,
  lib,
  host,
  ...
}:
let
  inherit (cmn) scheme;
  wallpaper = scheme.wallpaper;
  wallpaper-flipped = scheme.wallpaper-flipped or wallpaper;
  kb-icon = ./icons/kb.png;

  xiaomi = "desc:XMI Mi Monitor 3342300003039";
  dell = "desc:Dell Inc. DELL U2415 7MT0169R0CLS";

  switch-layout-kc = pkgs.writeShellScriptBin "switch-layout" ''
    keyboard="keychron-keychron-q8-keyboard"
    hyprctl switchxkblayout $keyboard next
    value=$(hyprctl devices | grep -i "$keyboard" -A 2 | tail -n1 | cut -d ' ' -f3-)
    notify-send -t 1800 -i ${kb-icon} "$value" "Changed keyboard layout to: $value"
  '';

  switch-layout-hw = pkgs.writeShellScriptBin "switch-layout" ''
    keyboard="at-translated-set-2-keyboard"
    hyprctl switchxkblayout $keyboard next
    value=$(hyprctl devices | grep -i "$keyboard" -A 2 | tail -n1 | cut -d ' ' -f3-)
    notify-send -t 1800 -i ${kb-icon} "$value" "Changed keyboard layout to: $value"
  '';

  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    hyprctl hyprpaper wallpaper "${xiaomi},${wallpaper-flipped}"
    hyprctl hyprpaper wallpaper "${dell},${wallpaper}"
  '';

  set-wallpaper-loid = pkgs.writeShellScriptBin "set-wallpaper" ''
    hyprctl hyprpaper wallpaper "eDP-1,${wallpaper}"
  '';

  set-ram-rgb = pkgs.writeShellScriptBin "set-ram-rgb" ''
    openrgb -d 0 -m Static -c ${cmn.scheme.ram} -b 100
  '';

  c = config.colorScheme.palette;
in

{
  wayland.windowManager.hyprland =
  {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    extraConfig = lib.optionalString (host == "albrecht") ''
      monitor = ${dell},1920x1200@59.95,0x0,1
      monitor = ${xiaomi},2560x1440@164.99899,1920x0,1

      workspace = ${xiaomi}, 1
      workspace = ${dell}, 2
      workspace = ${xiaomi}, 3
      workspace = ${dell}, 4
      workspace = ${xiaomi}, 5
      workspace = ${dell}, 6
      workspace = ${xiaomi}, 7
      workspace = ${dell}, 8
      workspace = ${xiaomi}, 9
      workspace = ${dell}, 10
    '' + lib.optionalString (host == "loid") ''
      monitor = eDP-1,2160x1440@60,0x0,1
    '' + ''
      env = XCURSOR_SIZE,2

      input {
        kb_layout = us, us(altgr-intl), de
        kb_variant = nodeadkeys
        follow_mouse = 1
        touchpad {
          natural_scroll = true
          scroll_factor = 0.3
        }
      }

      misc {
        disable_hyprland_logo = true
      }

      general {
        gaps_in = 8
        gaps_out = 16
        border_size = 3
        col.active_border = rgba(${c.base03}FF)
        col.inactive_border = rgba(${c.base00}FF)
        layout = dwindle
      }

      decoration {
        rounding = 0
        blur {
          enabled = true
          size = 6
          passes = 1
        }
        drop_shadow = false
      }
      animations {
        enabled = yes
        bezier = myBezier, 0.1, 0.9, 0.1, 1.05
        animation = windows, 1, 5, myBezier, slide
        animation = windowsOut, 1, 5, myBezier, slide
        animation = fade, 1, 7, default
        animation = workspaces, 1, 3, default
      }

      dwindle {
        no_gaps_when_only = false
        force_split = 0
        special_scale_factor = 0.8
        split_width_multiplier = 1.0
        use_active_for_splits = true
        pseudotile = yes
        preserve_split = yes
      }

      master {
        new_is_master = true
        special_scale_factor = 0.8
        no_gaps_when_only = false
      }

      $mainMod = SUPER
      $shiftMod = SUPERSHIFT

      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, C, killactive
      bind = $mainMod, F, fullscreen
      bind = $mainMod, E, exec, nautilus
      bind = $mainMod, V, togglefloating
      bind = $mainMod, R, exec, rofi -show drun -show-icons
      bind = $mainMod, J, togglesplit # dwindle
      bind = $mainMod, A, exec, rofi -show calc -no-show-match -no-sort
      bind = $mainMod, T, exec, thunderbird
      bind = $mainMod, B, exec, firefox
      bind = $mainMod, S, exec, spotify
      bind = $mainMod, D, exec, discord
      bind = $mainMod, Escape, exec, rofi -show "power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu --choices=shutdown/reboot/suspend/logout"
      bind = $mainMod, K, exec, clipman pick -t rofi
      bind = $mainMod, O, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a
      bind = $mainMod, L, exec, hyprlock
      bind = $mainMod, P, exec, HYPRSHOT_DIR=~/Pictures hyprshot -m window
      bind = $shiftMod, P, exec, HYPRSHOT_DIR=~/Picutres hyprshot -m region
    '' + lib.optionalString (host == "albrecht") ''
      bind = $mainMod, space, exec, ${switch-layout-kc}/bin/switch-layout
      bind = $mainMod, W, exec, ${set-wallpaper}/bin/set-wallpaper & ${set-ram-rgb}/bin/set-ram-rgb
    '' + lib.optionalString (host == "loid") ''
      bind = $mainMod, space, exec, ${switch-layout-hw}/bin/switch-layout
      bind = $mainMod, W, exec, ${set-wallpaper-loid}/bin/set-wallpaper
    '' + ''
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

      windowrule = center, class:idea-community

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow


      binde=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+
      binde=, XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-
      binde=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      binde=, XF86MonBrightnessDown,exec,brightnessctl set 5%-
      binde=, XF86MonBrightnessUp,exec,brightnessctl set +5%

      bindl=,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, 2160x1440, 0x0, 1"
      bindl=,switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"

      exec-once = hyprctl setcursor ${cmn.cursors.name} ${builtins.toString cmn.cursors.size}
      exec-once = waybar
      exec-once = dunst 
      exec-once = hypridle
      exec-once = nm-applet --indicator
      exec-once = blueman-applet
      exec-once = hyprctl dispatch exec "[workspace 9 silent]" spotify
      exec-once = hyprpaper
      exec-once = wl-paste -t text --watch clipman store -P --histpath="~/.local/share/clipman-primary.json"
    '';

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

  programs.hyprlock = let
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
      hexToRGB = hexToRGBString ", ";
      monitor = if host == "albrecht" then "DP-1" else "";
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
          inherit monitor;
          size = "200, 50";
          position = "0, -120";
          halign = "center";
          valign = "center";
          font_color = "rgb(${hexToRGB c.base03})";
          inner_color = "rgba(${hexToRGB c.base01}, 0.8)";
          outer_color = "rgba(${hexToRGB c.base01}, 0.8)";
          check_color = "rgb(${hexToRGB c.base06})";
          fail_color = "rgb(${hexToRGB c.base08})";
          font_family = "Iosevka Nerd Font";
        }
      ];

      label = [
        {
          inherit monitor;
          text = ''cmd[update:1000] echo "$(date +"%R")"'';
          color = "rgba(${hexToRGB c.base01}, 0.8)";
          font_size = 120;
          position = "0, -300";
          halign = "center";
          valign = "top";
          font_family = "Iosevka Nerd Font Bold";
        }
        {
          inherit monitor;
          text = "Servus, Kilian";
          color = "rgba(${hexToRGB c.base01}, 0.8)";
          font_size = 25;
          position = "0, -40";
          halign = "center";
          valign = "center";
          font_family = "Iosevka Nerd Font Bold";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    hyprpaper
    hyprpicker
    hyprshot
  ];

  home.sessionVariables = {
    HYPRSHOT_DIR = "~/Pictures/";
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    preload = ${wallpaper-flipped}
  '';
}
