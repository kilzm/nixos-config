{ pkgs, lib, ... }:
let
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

  services.udev = { packages = [ pkgs.openrgb_git ]; };

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb_git;
    motherboard = "amd";
  };
}
