{
  config,
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    waypaper
  ];
  xdg.configFile."waypaper/config.ini".text = ''
    [Settings]
    folder = ${config.home.homeDirectory}/nixos-config/wallpapers
    post_command = rm ~/.wallpaper; ln -s $wallpaper ~/.wallpaper
    backend = swww
    swww_transition_type = grow
    swww_transition_fps = 60
  '';
}
