{ config, pkgs, inputs, cmn, ... }:

let
  openrgb-fury5 = pkgs.openrgb.overrideAttrs (_: {
      pname = "openrgb-fury5";
      src = pkgs.fetchFromGitLab {
        owner = "geofbot";
        repo = "OpenRGB";
        rev = "fury_ddr5";
        hash = "sha256-W4XsasipJg5RvIj9mTiNytD8dh6fuEpHpzv6varaRKg=";
    };
  });
in

{
  nixpkgs = {
    config.allowUnfree = true;
  };

  imports = [
    ./hardware-configuration.nix
  ];
  
  networking = {
    hostName = "nixos";
    hosts = {
      "192.168.178.39" = [ "BRN30055C28FBC7.local" "BRN30055C28FBC7" ];
    };
    networkmanager.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # network printing
  services.printing = {
    enable = true;
  };

  programs.system-config-printer.enable = true;

  # boot
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
  };


  hardware.i2c = {
    enable = true;
  };

  # Set your time zone.
  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
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

  services.udev = {
    packages = [ openrgb-fury5 ];
  };

  services.hardware.openrgb = {
    enable = true;
    package = openrgb-fury5;
    motherboard = "amd";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kilianm = {
    isNormalUser = true;
    description = "Kilian Markl";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      (let python-packages = p: with p; [
        pandas
        requests
        numpy
        click
        pygobject3
        gst-python
      ]; in python311.withPackages python-packages)    

    vim
    git
    vscodium

    libsForQt5.plasma-framework
    libsForQt5.qt5.qtgraphicaleffects

    usbutils
    evtest
  ];

  programs = {
    zsh = {
      enable = true;
    };
    hyprland = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { 
        fonts = [ 
          "FiraCode"
          "DroidSansMono"
          "JetBrainsMono"
          "Gohu"
          "Iosevka"
          "IosevkaTerm"
          "Ubuntu"
          "UbuntuMono"
          "Hack"
        ];
      })
      font-awesome
      jetbrains-mono
      inter
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  systemd.services = {
    openrgb-ram = {
      script = ''
        ${openrgb-fury5}/bin/openrgb -d 0 -m Static -c 0354d7 -b 100
      '';
      wantedBy = [ "default.target" ];
    };

  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  console.colors = with cmn.colorScheme.colors; [
    base00
    base08
    base07
    base0A
    base0D
    base0E
    base07
    base06

    base03
    base08
    base07
    base0A
    base0D
    base0E
    base07
  ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
