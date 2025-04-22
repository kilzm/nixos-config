{ inputs, pkgs, ... }: {
  home.packages = (with pkgs; [
    wine
    winetricks
    heroic
    rare
    lutris
    prismlauncher
    ryubing
    _2ship2harkinian
  ]) ++ (with inputs.stable.legacyPackages.${pkgs.system}; [
    protonup-qt
    cemu
    lime3ds
    dolphin-emu
  ]);

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    no_display
    cpu_stats
    gpu_stats
    gpu_temp
    ram
    vram
    frametime
    engine_version
  '';
}
