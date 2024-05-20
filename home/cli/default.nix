{ pkgs, config, ... }: {
  imports =
    [ ./starship ./nerdfetch ./git ./cava ./direnv ./eza ./zoxide ./fzf ./bat ];

  home.packages = with pkgs; [
    ripgrep
    tree
    tldr
    trashy
    dust
    fd
    figlet
    lm_sensors
    sqlite
    imagemagick
    jq
    feh

    cmatrix
    pipes-rs

    gnumake
    openjdk
    gradle
    clang
    nodejs
  ];

  home.file = {
    ".sdks/openjdk".source = config.lib.file.mkOutOfStoreSymlink pkgs.openjdk;
  };
}
