{ inputs, pkgs, ... }: {
  home.packages = (with pkgs; [
    wine
    winetricks
    protonup-qt
    heroic
    rare
    lutris
    prismlauncher
    lime3ds
  ]) ++ (with inputs.stable.legacyPackages.${pkgs.system}; [
    joycond
    joycond-cemuhook
    cemu
    dolphin-emu
  ]);
}
