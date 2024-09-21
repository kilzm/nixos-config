{ inputs, self, pkgs, lib, ... }: {
  imports = [
    ./foot
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
    webcord
    telegram-desktop
    signal-desktop
    whatsapp-for-linux
    zotero
    solaar
    vlc
    pavucontrol
  ] ++ (with self.packages.${pkgs.system}; [
    gdb-frontend
    lldbg
  ]) ++ (with inputs.zen-browser.packages.${pkgs.system}; [
        generic
  ]);

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
