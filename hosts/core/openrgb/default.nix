{ pkgs, lib, ... }:
let
  openrgb-master = pkgs.openrgb-with-all-plugins.overrideAttrs (_: {
    version = "master";
    src = pkgs.fetchFromGitLab {
      owner = "CalcProgrammer1";
      repo = "OpenRGB";
      rev = "ff392ba61deff1bff57ca41dc52a088feceb1b47";
      hash = "sha256-T8jGd2aemoZUJ9s58gM3/nT0b0WPH37ZJ/hzRErPxsg=";
    };

    postPatch = ''
      patchShebangs scripts/build-udev-rules.sh
      substituteInPlace scripts/build-udev-rules.sh \
        --replace "/usr/bin/env chmod" "${pkgs.coreutils}/bin/chmod"
    '';
  });

  kfrgb = pkgs.stdenvNoCC.mkDerivation {
    pname = "kfrgb";
    version = "0.9.11";
    src = pkgs.fetchFromGitHub {
      owner = "KeyofBlueS";
      repo = "kfrgb";
      rev = "30b0175cd7eed19e51232d65f0141cd94072b140";
      hash = "sha256-uWvyKtwUK/tNkpUEm5nyk5/mDepxMp4ipnnYElQFeo0=";
    };

    nativeBuildInputs = [ pkgs.makeWrapper ];
    installPhase = ''
      mkdir -p $out/bin
      substituteInPlace kfrgb.sh --replace "/bin/bash" "${pkgs.bash}/bin/bash"
      cp kfrgb.sh $out/bin/kfrgb.sh
      chmod +x $out/bin/kfrgb.sh
      wrapProgram $out/bin/kfrgb.sh \
        --prefix PATH : ${lib.makeBinPath (with pkgs; [ i2c-tools yad  lshw ])}
    '';
  };
in
{
  environment.systemPackages = [
    kfrgb
  ];

  services.udev = { packages = [ openrgb-master ]; };

  services.hardware.openrgb = {
    enable = true;
    package = openrgb-master;
    motherboard = "amd";
  };
}
