{ pkgs, lib, ... }:
let
  openrgb-master = pkgs.openrgb-with-all-plugins.overrideAttrs (_: {
    version = "master";
    src = pkgs.fetchFromGitLab {
      owner = "CalcProgrammer1";
      repo = "OpenRGB";
      rev = "50f4bb5e5ace05f4b7278114e02e55577d35d5e9";
      hash = "sha256-QPT3Td3Xcm8Mf7JqJJi/AVebJlU5bFNDIsZQpB6dsIU=";
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
