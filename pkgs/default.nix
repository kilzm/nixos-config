{ pkgs }:
let inherit (pkgs) callPackage;
in {
  dipc = callPackage ./dipc { };
  kanagawa-gtk = callPackage ./kanagawa-gtk { };
}
