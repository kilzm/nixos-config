{ pkgs, ... }: {
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
    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    supportedFilesystems = [ "ntfs" ];
    kernelParams = [ "video=eDP-1:2160x1440@60" ];
  };

  hardware.i2c = { enable = true; };

  services.displayManager = { sessionPackages = with pkgs; [ hyprland ]; };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    videoDrivers = [ "intel" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.sessionPath = with pkgs; [
      mutter
      gnome-shell
      nautilus
    ];
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
    driSupport = true;
    driSupport32Bit = true;
  };

  system.stateVersion = "23.05";
}
