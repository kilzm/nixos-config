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
    ./browser
    ./zsh
    ./kitty
    ./waybar
    ./vscode
    ./spotify
    ./hyprland
    ./rofi
    ./wlogout
    ./thunderbird
    ./nvim
    ./dunst
  ];

  colorScheme = inputs.nix-colors.colorSchemes.nord;

  nixpkgs = {
    # You can add overlays here
    overlays = with inputs; [
      (import "${inputs.rycee-nur}/overlay.nix")
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      #   builtins.elem (lib.getName pkg) [
      #     "spotify"
      #     "betterttv"
      #   ];
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
      tldr

      # desktop
      steam
      discord
      spotifyd
      neovide
      cinnamon.nemo

      # info
      neofetch
      pfetch
      htop
      lm_sensors

      wev
      cmatrix
      playerctl
      sqlite
      gnome.nautilus
    ];
    sessionVariables = {
      GTK_THEME = "Nordic";
      EZA_ICON_SPACING = 2;
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "Kilian Markl";
      userEmail = "kilian02.markl@gmail.com";
      diff-so-fancy.enable = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      enableAliases = true;
      icons = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    ripgrep = {
      enable = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "Nord";
      };
    };
    bottom = {
      enable = true;
    };
  };

  xdg.mimeApps.defaultApplications = {
  };

  gtk = {
    enable = true;
    font = {
      name = "Ubuntu Nerd Font 10";
    };
    theme = {
      name = "Nordic-darker";
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
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
