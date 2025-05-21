{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Class = "0x000414";
        DiscoverableTimeout = 0;
        PairableTimeout = 0;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];

  services.blueman = {
    enable = true;
  };
}
