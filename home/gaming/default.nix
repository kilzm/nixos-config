{ pkgs, ... }: {
  home.packages = with pkgs; [
    wine
    winetricks
    protonup-qt
    heroic
    rare
    lutris
    prismlauncher
    joycond
    joycond-cemuhook
    cemu
    dolphin-emu
    # lime3ds
    # shipwright
    # _2ship2harkinian
  ];
}
