{ config, ... }: {
  services.dunst = {
    settings.global = { font = "${config.theming.fonts.sans} 16"; };
  };
}
