{ pkgs, host, ... }: {
  imports = [ ./${host}.nix ./hyprland ./ags ./gnome ./qt ./waypaper ];

  theming = {
    cursors = {
      name = "phinger-cursors-dark";
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
    mission-center
    jetbrains.clion
  ];
}
