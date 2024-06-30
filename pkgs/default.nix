{ pkgs }:
let inherit (pkgs) callPackage;
in {
  dipc = callPackage ./dipc { };
}
