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

    packages = (with pkgs; [
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
    ]) ++ (with pkgs.nerd-fonts; [
      fira-code
      droid-sans-mono
      jetbrains-mono
      gohufont
      iosevka
      iosevka-term
      ubuntu
      ubuntu-mono
      ubuntu-sans
      hack
      sauce-code-pro
      fantasque-sans-mono
      mononoki
      monaspace
      space-mono
      zed-mono
    ]);
  };
}
