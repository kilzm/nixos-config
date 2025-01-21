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
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "video=DP-1:2560x1440@165" "video=DP-5:1920x1200@60" "amd_pstate=active" "mt7921e.disable_aspm=Y" ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    supportedFilesystems = [ "ntfs" ];
  };

  systemd.services = {
    disable-wifi-bt-on-suspend = {
      enable = true;
      description = "Disable Wi-Fi and Bluethooth on suspend";
      before = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];
      wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.util-linux}/bin/rfkill block all";
      };
    };
    enable-wifi-bt-on-resume = {
      enable = true;
      description = "Enable Wi-Fi and Bluethooth on resume";
      after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];
      wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.util-linux}/bin/rfkill unblock all";
      };
    };
  };

  # systemd.tmpfiles.rules =
  #   [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

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
