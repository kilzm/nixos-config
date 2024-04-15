{ pkgs, ... }:
{
  imports = [
    ./loid-hw.nix
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
    ./modules/power
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
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    supportedFilesystems = [ "ntfs" ];
  };

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

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  system.stateVersion = "23.05";
}
