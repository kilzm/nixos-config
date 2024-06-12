{ pkgs, ... }: {
  imports = [
    ./kitty
    ./zsh
    ./nvim
    ./yazi
    ./zathura
    ./btop
    ./browser
    ./spotify
    ./thunderbird
    ./vscode
  ];

  home.packages = with pkgs; [
    webcord
    telegram-desktop
    signal-desktop
    whatsapp-for-linux
    zotero
    solaar
    vlc
  ];

  xdg.mimeApps = {
    defaultApplications = {
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    };
    associations.added = {
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    };
  };
}
