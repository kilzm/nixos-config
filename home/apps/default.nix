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
    ./vscode
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
  ] ++ (with self.packages.${pkgs.system}; [
    gdb-frontend
    zen-browser
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
    };
    associations.added = {
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    };
  };
}
