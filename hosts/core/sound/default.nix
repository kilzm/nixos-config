{pkgs, ...}: {
  services.pulseaudio = {
    enable = false;
    package = pkgs.pulseaudioFull;
    configFile = pkgs.writeText "default.pa" ''
      load-module module-bluetooth-policy
      load-module module-bluetooth-discover
      load-module module-loopback
    '';
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
