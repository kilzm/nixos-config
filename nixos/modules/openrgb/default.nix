{ pkgs, ... }:
let
  openrgb-fury5 = pkgs.openrgb.overrideAttrs (_: {
    pname = "openrgb-fury5";
    src = pkgs.fetchFromGitLab {
      owner = "geofbot";
      repo = "OpenRGB";
      rev = "fury_ddr5";
      hash = "sha256-TBHm2qzuUTxJvRMYKkWdRCVvZFdcwdp21H+7/gAGezY=";
    };
  });
in
{
  services.udev = {
    packages = [ openrgb-fury5 ];
  };

  services.hardware.openrgb = {
    enable = true;
    package = openrgb-fury5;
    motherboard = "amd";
  };
}
