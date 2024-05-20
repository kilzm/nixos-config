{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = { theme = "kanagawa"; };
    themes = {
      kanagawa = {
        src = pkgs.fetchFromGitHub {
          owner = "obergodmar";
          repo = "kanagawa-tmTheme";
          rev = "edb1e41256421a7b26348c80146bcff2c3e37f34";
          sha256 = "5Gj0Jz6UUm55v5d7V7E89ujUDSn0aGsZrOMS5FXduAE=";
        };
        file = "Kanagawa.tmTheme";
      };
    };
  };
}
