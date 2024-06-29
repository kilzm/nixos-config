{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../core/nix
    ../core/users
    ../core/pkgs
    ../core/displaymanager
    ../core/desktop
    ../core/networking
    ../core/printing
    ../core/locale
    ../core/sound
    ../core/bluetooth
    ../core/power
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 2;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    supportedFilesystems = [ "ntfs" ];
    kernelParams = [ "video=eDP-1:2160x1440@60" ];
  };

  hardware.i2c = { enable = true; };

  services.xserver.videoDrivers = [ "intel" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  system.stateVersion = "23.05";
}
