{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        style = "slight";
        autohint = true;
      };
    };
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DroidSansMono"
          "JetBrainsMono"
          "Gohu"
          "Iosevka"
          "IosevkaTerm"
          "Ubuntu"
          "UbuntuMono"
          "UbuntuSans"
          "Hack"
          "SourceCodePro"
          "FantasqueSansMono"
          "Mononoki"
          "Monaspace"
          "SpaceMono"
        ];
      })
      font-awesome
      jetbrains-mono
      inter
      iosevka
      roboto
      roboto-serif
      noto-fonts
      cantarell-fonts
      overpass
      cozette
    ];
  };
}
