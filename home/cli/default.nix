{ pkgs, config, self, ... }: {
  imports =
    [ ./starship ./nerdfetch ./git ./cava ./direnv ./eza ./zoxide ./fzf ./bat ./tmux ];

  home.packages = (with pkgs; [
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
    pwndbg
  ]) ++ (with self.packages.${pkgs.system}; [
    catnap
  ]);

  home.file = {
    ".sdks/openjdk".source = config.lib.file.mkOutOfStoreSymlink pkgs.openjdk;
  };
}
