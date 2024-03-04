{ pkgs, cmn, ... }:
{
  console = {
    packages = with pkgs; [ terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    colors = with cmn.scheme.base16.palette; [
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
  };
}
