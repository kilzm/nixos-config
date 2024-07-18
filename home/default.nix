{ host, ... }: {
  imports = [
    ./${host}.nix
    ./cli
    ./desktop
    ./apps
  ];

  programs.home-manager.enable = true;

  home = {
    username = "kilianm";
    homeDirectory = "/home/kilianm";
  };

  xdg.mimeApps.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
