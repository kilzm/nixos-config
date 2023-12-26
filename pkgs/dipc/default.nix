{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "dipc";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "doprz";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-sVSlkoQ3SuePbex4qFityzQwte7wgsCOv3P66wUFUUk=";
  };
  cargoHash = "sha256-XQ85T64K1NLdSOtAFr0XluvFNTaHzoWKxoQtBQ+uSKQ=";
}
