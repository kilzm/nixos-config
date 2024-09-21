{ clangStdenv
, cmake
, pkg-config
, xorg
, libX11
, libxkbcommon
, libGL
, libGLU
, wayland-scanner
, wayland
, wayland-protocols
, lldb
, fetchFromGitHub
, makeWrapper
}:

clangStdenv.mkDerivation {
  pname = "lldbg";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "yigithanyigit";
    repo = "lldbg";
    rev = "master";
    hash = "sha256-te7Xw9R1KLvGC0VUG1+U9B8sq3uxZ+FQGz/TjJIZLxo=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXi
    wayland
    wayland-protocols
    wayland-scanner
    libxkbcommon
    libGLU
    libGL
    lldb
  ];

  cmakeFlags = [
    "-DOPENGL_glu_LIBRARY:FILEPATH=${libGLU}/lib/libGLU.so"
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ../bin/lldbgui $out/bin
  '';

  postFixup = ''
    wrapProgram $out/bin/lldbgui \
      --unset WAYLAND_DISPLAY \
  '';
}
