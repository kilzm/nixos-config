{
  lib,
  stdenv,
  makeWrapper,
  fetchFromGitHub,
  libX11,
  pkg-config,
  gdb,
  freetype,
  freetypeSupport ? true,
}:

stdenv.mkDerivation {
  pname = "gf";
  version = "unstable-2025-04-12";

  src = fetchFromGitHub {
    repo = "gf";
    owner = "nakst";
    rev = "162249220bde1c9fef7d87f8bb9128be9323d93f";
    hash = "sha256-wP8ELlqtMwYv6/jQzKahaX7vlMKLUBgxm5Io49tphsM=";
  };

  nativeBuildInputs = [
    makeWrapper
    pkg-config
  ];

  buildInputs = [
    libX11
    gdb
  ] ++ lib.optional freetypeSupport freetype;

  preConfigure = ''
    patchShebangs build.sh
  '';

  buildPhase = ''
    runHook preBuild
    extra_flags=-DUI_FREETYPE_SUBPIXEL ./build.sh
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp gf2 "$out/bin/"
    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/gf2 --prefix PATH : ${lib.makeBinPath [ gdb ]}
  '';

  meta = with lib; {
    description = "GDB Frontend";
    homepage = "https://github.com/nakst/gf";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "gf2";
    maintainers = with maintainers; [ _0xd61 ];
  };
}
