{...}: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        energy_performance_preference = "power";
        turbo = "never";
        enable_thresholds = true;
        stop_threshold = 90;
      };
      charger = {
        governor = "performance";
        energy_performance_preference = "balance_performance";
        turbo = "auto";
      };
    };
  };

  services.thermald = {
    enable = true;
  };

  services.upower = {
    enable = true;
  };
}
