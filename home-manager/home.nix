{
  inputs,
  lib,
  config,
  pkgs,
  cmn,
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

  colorScheme = cmn.colorScheme;

  nixpkgs = {
    overlays = with inputs; [
      (import "${inputs.rycee-nur}/overlay.nix")
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "kilianm";
    homeDirectory = "/home/kilianm";
    packages = with pkgs; [
      # programming
      gcc
      jdk20
      gradle
      jetbrains.idea-community
      texlive.combined.scheme-full

      # cli tools
      tree
      ranger
      tldr

      # desktop apps
      steam
      discord
      spotifyd
      neovide

      # gnome
      gnome.eog
      gnome.nautilus
      gnome.sushi
      gnome.geary
      evince
      libsForQt5.dolphin

      # info
      neofetch
      pfetch
      htop
      lm_sensors

      # hyprland desktop
      dunst
      libnotify
      libappindicator
      swww
      networkmanagerapplet

      # misc
      cmatrix
      playerctl
      sqlite
      imagemagick
    ];

    file = {
      ".config/gtk-3.0/gtk.css".source = "${inputs.nordic-theme}/gtk-3.0/gtk-dark.css";
      ".config/gtk-4.0/gtk.css".source = "${inputs.nordic-theme}/gtk-4.0/gtk-dark.css";
      ".sdks/openjdk".source = config.lib.file.mkOutOfStoreSymlink pkgs.openjdk;
    };

    sessionVariables = {
      EZA_ICON_SPACING = 2;
      FONT = cmn.font;
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
      name = "${cmn.font} 11";
    };
    theme = {
      inherit (cmn.theme) name package;
    };
    cursorTheme = {
      inherit (cmn.cursors) name package;
    };
    iconTheme = {
      inherit (cmn.icons) name package;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk2";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
