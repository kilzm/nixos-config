{ pkgs, ... }: {
  imports = [ ./hyprland ./waybar ./dunst ./rofi ./gnome ./qt ./wlogout ];

  theming = {
    cursors = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
    };
    icons = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur-dark";
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
