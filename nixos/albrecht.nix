{ pkgs, ... }:
{
  imports = [
    ./albrecht-hw.nix
    ./modules/nix
    ./modules/users
    ./modules/pkgs
    ./modules/console
    ./modules/networking
    ./modules/printing
    ./modules/locale
    ./modules/sound
    ./modules/bluetooth
    ./modules/openrgb
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
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    supportedFilesystems = [ "ntfs" ];
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
    driSupport = true;
    driSupport32Bit = true;
  };
  
  hardware.steam-hardware.enable = true;
  hardware.keyboard.qmk.enable = true;
  hardware.i2c = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant =  "";
    };
    videoDrivers = [ "amdgpu" ];
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      sessionPackages = with pkgs; [
        hyprland
      ];
    };
  };

  system.stateVersion = "23.05";
}
