{
  self,
  pkgs,
  ...
}: {
  imports = [
    ./ghostty
    ./zsh
    ./nvim
    ./yazi
    ./btop
    ./browser
    ./spotify
    ./thunderbird
  ];

  home.packages = with pkgs;
    [
      protonvpn-gui
      vesktop
      telegram-desktop
      signal-desktop
      whatsapp-for-linux
      zotero
      solaar
      vlc
      imhex
      pavucontrol
      pwvucontrol
      mission-center
      obs-studio
      gf
    ]
    ++ (with self.packages.${pkgs.system}; [
      gdb-frontend
    ]);

  xdg.mimeApps = {
    defaultApplications = {
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
      "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
    };
  };
}
