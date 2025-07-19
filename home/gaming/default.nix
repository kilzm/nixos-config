{
  inputs,
  pkgs,
  ...
}: {
  home.packages =
    (with pkgs; [
      wine
      bottles
      winetricks
      rare
      lutris
      ryubing
      azahar
      protonplus
      dolphin-emu
      heroic
      cemu
    ])
    ++ (with inputs.stable.legacyPackages.${pkgs.system}; [
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
