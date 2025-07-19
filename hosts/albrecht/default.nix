{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../core/ssd
    ../core/nix
    ../core/users
    ../core/pkgs
    ../core/security
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
      };
    };
    kernelPackages = pkgs.linuxPackages_lqx;
    kernelParams = [
      "video=DP-1:2560x1440@165"
      "video=DP-5:1920x1200@60"
      "amd_pstate=active"
      "mt7921e.disable_aspm=Y"
      "amdgpu.dcdebugmask=0x10"
    ];
    kernelModules = [
      "i2c-dev"
      "i2c-piix4"
    ];
    supportedFilesystems = ["ntfs"];
  };

  chaotic = {
    mesa-git.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu = {
    initrd.enable = true;
  };

  hardware.steam-hardware.enable = true;
  hardware.keyboard.qmk.enable = true;
  hardware.i2c = {
    enable = true;
  };

  services.xserver.videoDrivers = ["modesetting"];

  services.flatpak.enable = true;

  system.stateVersion = "23.05";
}
