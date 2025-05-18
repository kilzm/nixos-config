{
  inputs,
  pkgs,
  ...
}: {
  services.hypridle = {
    enable = true;
    # package = inputs.hypridle.packages.${pkgs.system}.hypridle;
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
}
