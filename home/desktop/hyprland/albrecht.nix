{ pkgs, config, ... }:
let
  xiaomi = "desc:XMI Mi Monitor 3342300003039";
  dell = "desc:Dell Inc. DELL U2415 7MT0169R0CLS";

  kb-icon = ./icons/kb.png;

  switch-layout-kc = pkgs.writeShellScriptBin "switch-layout" ''
    keyboard="keychron-keychron-q8-keyboard"
    hyprctl switchxkblayout $keyboard next
    value=$(hyprctl devices | grep -i "$keyboard" -A 2 | tail -n1 | cut -d ' ' -f3-)
    notify-send -t 1800 -i ${kb-icon} "$value" "Changed keyboard layout to: $value"
  '';
in
{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "${dell},1920x1200@60,0x0,1"
        "${xiaomi},2560x1440@165,1920x0,1"
      ];

      decoration = {
        drop_shadow = true;
        shadow_range = 7;
        shadow_render_power = 3;
        "col.shadow" = "0x66000000";

        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          noise = 0;
          ignore_opacity = true;
          popups = true;
          xray = true;
        };
      };

      workspace = [
        "1, monitor:${xiaomi}, default:true"
        "2, monitor:${dell}, default:true"
        "3, monitor:${xiaomi}"
        "4, monitor:${dell}"
        "5, monitor:${xiaomi}"
        "6, monitor:${dell}"
        "7, monitor:${xiaomi}"
        "8, monitor:${dell}"
        "9, monitor:${xiaomi}"
        "10, monitor:${dell}"
      ];

      bind = [
        "$mainMod, space, exec, ${switch-layout-kc}/bin/switch-layout"
        "$mainMod, W, exec, openrgb -d 0 -m Static -c ${config.theming.ram} -b 0"
      ];
    };
  };

  services.hyprpaper = {
    settings.wallpaper = [
      "${xiaomi},${config.wallpaper.flipped}"
      "${dell},${config.wallpaper.normal}"
    ];
  };
}
