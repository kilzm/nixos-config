{ pkgs, ... }:
{
  imports = [
    ./albrecht-hw.nix
    ./modules/nix
    ./modules/users
    ./modules/pkgs
    ./modules/console
    ./modules/desktop
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
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "video=DP-1:2560x1440@165"
      "video=DP-5:1920x1200@60"
    ];
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    supportedFilesystems = [ "ntfs" ];
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
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

  services.displayManager = {
    sessionPackages = with pkgs; [
      hyprland
    ];
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant =  "";
    };
    videoDrivers = [ "modesetting" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  system.stateVersion = "23.05";
}
