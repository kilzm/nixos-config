{ pkgs, ... }: {
  imports = [ ./hyprland ./waybar ./dunst ./rofi ./gnome ./qt ./wlogout ./waypaper ];

  theming = {
    cursors = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
    };
  };

  home.packages = with pkgs; [
    libnotify
    libappindicator
    swww
    networkmanagerapplet
    playerctl
    brightnessctl
    wl-clipboard
    onlyoffice-bin_latest
    zoom-us
  ];
}
