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
      protonplus
      heroic

      dolphin-emu
      cemu
      azahar
      ryubing
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
