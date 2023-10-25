{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

rec {

  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./browser.nix
    ./zsh.nix
    ./kitty.nix
    ./waybar.nix
    ./vscode.nix
    ./spotify.nix
    ./hyprland.nix
    ./rofi.nix
    ./wlogout.nix
    # ./nvim.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.nord;

  nixpkgs = {
    # You can add overlays here
    overlays = with inputs; [
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: 
        builtins.elem (lib.getName pkg) [
          "spotify"
        ];
    };
  };

  home = {
    username = "kilianm";
    homeDirectory = "/home/kilianm";
    packages = with pkgs; [
      # cli tools
      ripgrep
      tree
      ranger

      # desktop
      steam
      discord
      spotifyd

      # info
      neofetch
      pfetch
      htop

      wev
      cmatrix
      playerctl
      sqlite
      gnome.nautilus
    ];
    sessionVariables = {
      GTK_THEME = "Nordic-bluish-accent";
    };
  };

  programs = {
    eza = {
      enable = true;
      enableAliases = true;
      icons = true;
    };
    neovim = {
      enable = true;
    };
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "Kilian Markl";
      userEmail = "kilian02.markl@gmail.com";
    };
  };

  xdg.mimeApps.defaultApplications = {
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.inter;
      name = "Inter 10";
    };
    theme = {
      name = "Nordic-bluish-accent";
      package = pkgs.nordic;
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
    };
    iconTheme = {
      name = "Nordzy-dark";
      package = pkgs.nordzy-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = { 
      name = "Nordic-bluish-accent";
      package = pkgs.nordic;
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
