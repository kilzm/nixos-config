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
    ../core/openrgb
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "video=DP-1:2560x1440@165" "video=DP-5:1920x1200@60" ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    supportedFilesystems = [ "ntfs" ];
  };

  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.steam-hardware.enable = true;
  hardware.keyboard.qmk.enable = true;
  hardware.i2c = { enable = true; };

  programs.steam.enable = true;

  services.xserver.videoDrivers = [ "modesetting" ];

  system.stateVersion = "23.05";
}
