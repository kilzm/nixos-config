{ self, pkgs, inputs, ... }: {
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
    lite-xl
    vesktop
    telegram-desktop
    signal-desktop
    whatsapp-for-linux
    zotero
    solaar
    vlc
    imhex
    pavucontrol
  ] ++ (with self.packages.${pkgs.system}; [
    gdb-frontend
    zen-browser
  ]) ++ [
    # inputs.wezterm.packages.${pkgs.system}.default
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
