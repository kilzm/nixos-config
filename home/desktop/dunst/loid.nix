{ config, ... }: {
  services.dunst = {
    settings.global = { font = "${config.theming.font} 15"; };
  };
}
