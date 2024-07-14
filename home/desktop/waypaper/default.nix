{ config, inputs, pkgs, ... }: 
let
  update = pkgs.writeShellScriptBin "update" ''
    sleep 0.2
    systemctl --user restart dunst.service
    pywalfox update
    nvr --serverlist | while IFS= read -r line; do
      nvr --servername $line -c 'colo pywal16'
      nvr --servername $line -c 'lua vim.api.nvim_set_hl(0, "NonText", { bg = "#202020", fg = "#B6B6B6" })'
    done
  '';
in {
  home.packages = [ (pkgs.waypaper.overrideAttrs (old: {src = inputs.waypaper; })) ];
  xdg.configFile."waypaper/config.ini".text = ''
    [Settings]
    folder = ${config.home.homeDirectory}/nixos-config/wallpapers
    post_command = wal -i $wallpaper -a 85 --saturate 0.1 -n -q & ${update}/bin/update
    backend = swww
    swww_transition_type = any
    swww_transition_fps = 60
  '';
}
