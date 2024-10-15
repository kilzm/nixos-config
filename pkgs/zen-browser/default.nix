{ stdenv
, lib
, libGL
, libGLU
, libevent
, libffi
, libjpeg
, libpng
, libstartup_notification
, libvpx
, libwebp
, fontconfig
, libxkbcommon
, zlib
, freetype
, gtk3
, libxml2
, dbus
, xcb-util-cursor
, alsa-lib
, libpulseaudio
, pango
, atk
, cairo
, gdk-pixbuf
, glib
, ffmpeg
, libglvnd
, pipewire
, xorg
, makeWrapper
, copyDesktopItems
, wrapGAppsHook
}:
let
  libs = [
    stdenv.cc.cc
    libGL
    libGLU
    libevent
    libffi
    libjpeg
    libpng
    libstartup_notification
    libvpx
    libwebp
    fontconfig
    libxkbcommon
    zlib
    freetype
    gtk3
    libxml2
    dbus
    xcb-util-cursor
    alsa-lib
    libpulseaudio
    pango
    atk
    cairo
    gdk-pixbuf
    glib
    ffmpeg
    libglvnd
    pipewire
  ] ++ (with xorg; [
    libxcb
    libX11
    libXcursor
    libXrandr
    libXi
    libXext
    libXcomposite
    libXdamage
    libXfixes
    libXScrnSaver
  ]);
  libPath = lib.makeLibraryPath libs;
in
stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "1.0.1-a.10";
  src = builtins.fetchTarball {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
    sha256 = "sha256:1iwqfz9hmkmg0b57w8928hfmav1lyxq29dfp0q029m2cb40ypmk4";
  };

  desktopSrc = ./.;

  phases = [ "installPhase" "fixupPhase" ];

  nativeBuildInputs = [
    wrapGAppsHook
    copyDesktopItems
    makeWrapper
  ];

  installPhase = ''
    		  mkdir -p $out/bin && cp -r $src/* $out/bin
    		  install -D $desktopSrc/zen.desktop $out/share/applications/zen.desktop
    		  install -D $src/browser/chrome/icons/default/default128.png $out/share/icons/hicolor/128x128/apps/zen.png
    		'';

  fixupPhase = ''
    		  chmod 755 $out/bin/*
    		  patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/zen
    		  wrapProgram $out/bin/zen --set LD_LIBRARY_PATH "${libPath}" \
                        --set MOZ_LEGACY_PROFILES 1 --set MOZ_ALLOW_DOWNGRADE 1 --set MOZ_APP_LAUNCHER zen --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"
    		  patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/zen-bin
    		  wrapProgram $out/bin/zen-bin --set LD_LIBRARY_PATH "${libPath}" \
                        --set MOZ_LEGACY_PROFILES 1 --set MOZ_ALLOW_DOWNGRADE 1 --set MOZ_APP_LAUNCHER zen --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"
    		  patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/glxtest
    		  wrapProgram $out/bin/glxtest --set LD_LIBRARY_PATH "${libPath}"
    		  patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/updater
    		  wrapProgram $out/bin/updater --set LD_LIBRARY_PATH "${libPath}"
    		  patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/vaapitest
    		  wrapProgram $out/bin/vaapitest --set LD_LIBRARY_PATH "${libPath}"
    		'';

    meta.mainProgram = "zen";
}
