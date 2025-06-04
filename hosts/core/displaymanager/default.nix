{pkgs, ...}: {
  services.displayManager = {
    sessionPackages = with pkgs; [hyprland];
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
