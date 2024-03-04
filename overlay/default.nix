cmn: final: prev:
let
  inherit (prev) callPackage;
  wrapWithGTKTheme = pkg: name: prev.stdenv.mkDerivation {
    inherit (pkg) version pname;
    nativeBuildInputs = [ prev.makeWrapper ];
    buildInputs = [ pkg ];
    src = pkg;
    installPhase = ''
      mkdir $out
      cp -r ./* $out
      wrapProgram $out/bin/${name} --set GTK_THEME ${cmn.theme.name}
    '';
  };
in 
{
  kilzm = {
    dipc = callPackage ../pkgs/dipc { };
    kanagawa-gtk = callPackage ../pkgs/kanagawa-gtk { };

    nautilus = wrapWithGTKTheme prev.gnome.nautilus "nautilus";
    gnome-calendar = wrapWithGTKTheme prev.gnome.gnome-calendar "gnome-calendar";
  };
}
