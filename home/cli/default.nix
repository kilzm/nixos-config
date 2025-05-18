{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./starship
    ./fastfetch
    ./git
    ./direnv
    ./eza
    ./zoxide
    ./fzf
    ./bat
    ./tmux
  ];

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
    libqalculate
    netcat

    cmatrix
    pipes-rs

    gnumake
    openjdk
    gradle
    clang
    nodejs

    gdb
    lldb
    pwntools
    rar
  ];

  home.file = {
    ".sdks/openjdk".source = config.lib.file.mkOutOfStoreSymlink pkgs.openjdk;
  };
}
