{ ... }: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # network printing
  services.printing = { enable = true; };

  programs.system-config-printer.enable = true;
}
