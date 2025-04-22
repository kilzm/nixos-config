{ self, pkgs, ... }: {
  imports = [
    ./ghostty
    ./zsh
    ./nvim
    ./yazi
    ./zathura
    ./btop
    ./browser
    ./spotify
    ./thunderbird
    # ./vscode
    ./pywal16
  ];

  home.packages = with pkgs; [
    vesktop
    telegram-desktop
    signal-desktop
    whatsapp-for-linux
    zotero
    solaar
    vlc
    imhex
    pavucontrol
    mission-center
    obs-studio
    (gf.overrideAttrs (old: {
      version = "0-unstable-2025-04-14";
      src = pkgs.fetchFromGitHub {
        repo = "gf";
        owner = "nakst";
        rev = "162249220bde1c9fef7d87f8bb9128be9323d93f";
        hash = "sha256-wP8ELlqtMwYv6/jQzKahaX7vlMKLUBgxm5Io49tphsM=";
      };
    }))
  ] ++ (with self.packages.${pkgs.system}; [
    gdb-frontend
    zen-browser
    # gf
  ]) ++ [
  ];

  xdg.mimeApps = {
    defaultApplications = {
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
      "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
    };
    associations.added = {
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    };
  };
}
