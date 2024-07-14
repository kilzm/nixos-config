{ pkgs, ... }: {
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
