{ config, inputs, pkgs, ... }:
let
  update = pkgs.writeShellScriptBin "update" ''
    sleep 0.2
    systemctl --user restart dunst.service
    pywalfox update
    ags quit
    ags run --gtk4
    nvr --serverlist | while IFS= read -r line; do
      nvr --servername $line -c 'so $HOME/nixos-config/home/apps/nvim/config/lua/kilzm/misc.lua'
    done
  '';
in
{
  home.packages = with pkgs; [
    waypaper
  ];
  xdg.configFile."waypaper/config.ini".text = ''
    [Settings]
    folder = ${config.home.homeDirectory}/nixos-config/wallpapers
    post_command = wal -i $wallpaper -b "#141414" --fg "#f0f0f0" --saturate 0.15 -a 92 -n -q & ${update}/bin/update
    backend = swww
    swww_transition_type = grow
    swww_transition_fps = 60
  '';
}
