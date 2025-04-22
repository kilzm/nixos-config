{ inputs, pkgs, }:
let
  flakes = [ "neomodern-nvim" ];
  buildPlug = name:
    pkgs.vimUtils.buildVimPlugin {
      pname = name;
      version = "master";
      src = builtins.getAttr name inputs;
      doCheck = false;
    };
in
builtins.listToAttrs (map
  (name: {
    inherit name;
    value = buildPlug name;
  })
  flakes)
