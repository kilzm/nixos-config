{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../core/ssd
    ../core/nix
    ../core/users
    ../core/pkgs
    ../core/font
    ../core/displaymanager
    ../core/desktop
    ../core/networking
    ../core/printing
    ../core/locale
    ../core/sound
    ../core/bluetooth
    ../core/gaming
    ../core/openrgb
    ../core/virtualisation
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        configurationLimit = 10;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        minegrub-theme = {
          enable = true;
        };
      };
    };
    kernelPackages = pkgs.linuxPackages;
    kernelParams = [ "video=DP-1:2560x1440@165" "video=DP-5:1920x1200@60" "amd_pstate=active" ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    supportedFilesystems = [ "ntfs" ];
  };

  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu = {
    initrd.enable = true;
  };

  hardware.steam-hardware.enable = true;
  hardware.keyboard.qmk.enable = true;
  hardware.i2c = { enable = true; };

  services.xserver.videoDrivers = [ "modesetting" ];

  services.flatpak.enable = true;

  system.stateVersion = "23.05";
}
