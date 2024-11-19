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
    cemu
    joycond
    joycond-cemuhook
    dolphin-emu
  ]) ++ (with inputs.stable.legacyPackages.${pkgs.system}; [
  ]);
}
