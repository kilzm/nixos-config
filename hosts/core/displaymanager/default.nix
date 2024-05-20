{ pkgs, ... }: {
  services.displayManager = { sessionPackages = with pkgs; [ hyprland ]; };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
