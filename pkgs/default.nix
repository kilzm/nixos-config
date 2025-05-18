{pkgs}: let
  inherit (pkgs) callPackage;
in {
  gdb-frontend = callPackage ./gdb-frontend {};
}
