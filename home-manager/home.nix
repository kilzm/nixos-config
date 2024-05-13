{
  inputs,
  config,
  host,
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
    ./thunderbird
    ./nvim
    ./dunst
    # inputs.hyprlock.homeManagerModules.hyprlock
  ];

  colorScheme = cmn.scheme.base16;

  nixpkgs = {
    overlays = [
      (import "${inputs.rycee-nur}/overlay.nix")
      inputs.hyprpicker.overlays.default
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "electron-24.8.6"
        "zotero-6.0.27"
        "e"
      ];
    };

  };

  home = {
    username = "kilianm";
    homeDirectory = "/home/kilianm";
    packages = with pkgs; [
      # programming
      gnumake
      jdk20
      gradle
      jetbrains.idea-community
      texlive.combined.scheme-full
      llvmPackages_14.libllvm
      clang
      nodejs

      # cli tools
      tree
      tldr
      trashy
      dust
      fd
      figlet

      # gaming
      wine
      winetricks
      heroic
      rare
      lutris

      # desktop apps
      discord
      spotifyd
      telegram-desktop
      signal-desktop
      whatsapp-for-linux
      zotero
      solaar

      # gnome
      glib
      gnome.eog
      kilzm.nautilus
      gnome.sushi
      gnome.gnome-font-viewer
      gnome.gnome-weather
      gnome.gnome-calculator
      gnome.gnome-maps
      gnome.gnome-disk-utility
      kilzm.gnome-calendar
      gnome.gnome-system-monitor
      evince

      # info
      neofetch
      pfetch
      lm_sensors

      # hyprland desktop
      dunst
      libnotify
      libappindicator
      swww
      networkmanagerapplet
      playerctl
      brightnessctl
      wl-clipboard

      # misc
      cmatrix
      pipes-rs
      sqlite
      imagemagick
      kilzm.dipc
    ];

    sessionVariables = {
      EZA_ICON_SPACING = 2;
      FONT = cmn.font;
      GTK_THEME = cmn.theme.name;
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
    hyprlock.enable = true;
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
    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
    };
    eza = {
      enable = true;
      icons = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
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
        # theme = "Kanagawa";
      };
    };
    btop = {
      enable = true;
      settings = {
        rounded_corners = true;
        theme_background = false;
      };
    };
    jq = {
      enable = true;
    };
    lazygit = {
      enable = true;
      settings = {
        gui = {
          border = "rounded";
          theme = {
            inactiveBorderColor = [ "#363646" ];
            activeBorderColor = [ "default" "bold" ];
          };
        };
      };
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    cava = {
      enable = true;
      settings = {
        general = {
          sensitivity = 70;
          framerate = 165;
        };
        color = with colorScheme.palette; {
          gradient = 1;
          gradient_count = 4;
          gradient_color_1 = "'#${base0E}'";
          gradient_color_2 = "'#${base0C}'";
          gradient_color_3 = "'#${base0D}'";
          gradient_color_4 = "'#${base0F}'";
        };
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
        text-scaling-factor = if host == "loid" then 1.3 else 1.0;
        scaling-factor = 0;
    };
  };

  home.file = {
    ".sdks/openjdk".source = config.lib.file.mkOutOfStoreSymlink pkgs.openjdk;
  };

  xdg.configFile = {
    "gtk-3.0" = { source = cmn.scheme.gtk3; recursive = true; };
    "gtk-4.0" = { source = cmn.scheme.gtk4; recursive = true; };
  };

  xdg.mimeApps.defaultApplications = {
  };

  gtk = {
    enable = true;
    font = {
      name = "${cmn.font} 10";
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
    platformTheme.name = "gtk";
    style.name = cmn.qt-theme.name;
    style.package = cmn.qt-theme.package;
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
