{ stdenv, fetchFromGitHub, gdk-pixbuf, gtk-engine-murrine, gtk_engines, librsvg
}:

stdenv.mkDerivation rec {
  pname = "kanagawa-gtk";
  version = "master";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Kanagawa-GKT-Theme";
    rev = "35936a1e3bbd329339991b29725fc1f67f192c1e";
    sha256 = "sha256-BZRmjVas8q6zsYbXFk4bCk5Ec/3liy9PQ8fqFGHAXe0=";
  };

  buildInputs = [ gdk-pixbuf gtk_engines librsvg ];

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share
    cp -r themes $out/share
    cp -r icons $out/share
    runHook postInstall
  '';
}
