{ pkgs, self, ... }: {
  environment.systemPackages = with pkgs; [
    (
      let
        python-packages = p:
          with p; [
            pandas
            requests
            numpy
            click
            pygobject3
            gst-python
            dbus-python
          ];
      in
      python311.withPackages python-packages
    )

    nix-output-monitor
    nvd

    vim
    git
    vscodium

    libsForQt5.plasma-framework
    libsForQt5.qt5.qtgraphicaleffects

    usbutils
    evtest
  ];

  programs = {
    zsh = { enable = true; };
    hyprland = { enable = true; };
    dconf = { enable = true; };
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d";
      };
      flake = "/home/kilianm/nixos-config";
    };
  };

}
