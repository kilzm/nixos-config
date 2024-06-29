{ lib, pkgs, config, ... }:
let
  kb-icon = ./icons/kb.png;

  switch-layout-hw = pkgs.writeShellScriptBin "switch-layout" ''
    keyboard="at-translated-set-2-keyboard"
    hyprctl switchxkblayout $keyboard next
    value=$(hyprctl devices | grep -i "$keyboard" -A 2 | tail -n1 | cut -d ' ' -f3-)
    notify-send -t 1800 -i ${kb-icon} "$value" "Changed keyboard layout to: $value"
  '';
in
{
  imports = [
    ./hyprgrass.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [ "eDP-1,2160x1440@60,0x0,1" ];

      decoration.blur.enabled = lib.mkForce false;

      bind = [ "$mainMod, space, exec, ${switch-layout-hw}/bin/switch-layout" ];

      bindl = [
        ''
          ,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, 2160x1440, 0x0, 1"''
        '',switch:on:Lid Switch,exec,pidof hyprlock || hyprlock & hyprctl keyword monitor "eDP-1, disable"''
      ];
    };
  };

  services.hyprpaper = {
    settings.wallpaper = [ "eDP-1,${config.wallpaper.normal}" ];
  };
}
