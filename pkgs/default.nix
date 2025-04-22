{ pkgs }:
let inherit (pkgs) callPackage;
in {
  dipc = callPackage ./dipc { };
  catnap = callPackage ./catnap { };
  gdb-frontend = callPackage ./gdb-frontend { };
  lldbg = callPackage ./lldbg { };
  zen-browser = callPackage ./zen-browser { };
  gf = callPackage ./gf { };
}
