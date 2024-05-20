{ config, ... }: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [ "${config.wallpaper.normal}" "${config.wallpaper.flipped}" ];
    };
  };
}
