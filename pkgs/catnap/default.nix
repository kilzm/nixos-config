{ stdenvNoCC, nim, makeWrapper, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  name = "catnap";
  src = fetchFromGitHub {
    owner = "iinsertNameHere";
    repo = "catnap";
    rev = "cbb3186126f5772de00cfe0224752bd7dee14eee";
    sha256 = "sha256-eI+mgrJIFUyD8HjtHZUfFB2BqUM4pFn1vs0QnhL0Fw4=";
  };

  nativeBuildInputs = [ nim makeWrapper ];

  buildPhase = ''
    echo "const CURRENTCOMMIT* = \""\"\ > src/catnaplib/global/currentcommit.nim
    nim c \
      --nimcache:$TMPDIR \
      --cincludes:$src/src/extern/headers \
      --path:$src/src/extern/libraries \
      --verbosity:0 \
      --d:release \
      --outdir:./bin \
      src/catnap.nim
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/man/{man1,man5}

    install -Dm644 config/distros.toml $out/share/distros.toml
    install -Dm644 config/config.toml $out/share/config.toml

    install -Dm644 docs/catnap.1 $out/share/man/man1/catnap.1
    install -Dm644 docs/catnap.5 $out/share/man/man5/catnap.5

    install -Dm755 bin/catnap $out/bin/catnap
    wrapProgram "$out/bin/catnap" \
      --add-flags "-a $out/share/distros.toml" \
      --add-flags "-c $out/share/config.toml"
  '';
}
