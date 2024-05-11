{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (let python-packages = p: with p; [
      pandas
      requests
      numpy
      click
      pygobject3
      gst-python
      dbus-python
    ]; in python311.withPackages python-packages)    

    vim
    git
    vscodium

    libsForQt5.plasma-framework
    libsForQt5.qt5.qtgraphicaleffects

    usbutils
    evtest
  ];

  programs = {
    zsh = {
      enable = true;
    };
    hyprland = {
      enable = true;
    };
    steam = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
  };

  fonts = {
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
          "Hack"
          "SourceCodePro"
          "FantasqueSansMono"
          "Mononoki"
        ];
      })
      font-awesome
      jetbrains-mono
      inter
      iosevka
    ];
  };
}
