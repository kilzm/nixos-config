{ inputs, pkgs, }:
let
  flakes = [ "nvim-tree" "error-lens-nvim" ];
  buildPlug = name:
    pkgs.vimUtils.buildVimPlugin {
      pname = name;
      version = "master";
      src = builtins.getAttr name inputs;
    };
in
builtins.listToAttrs (map
  (name: {
    inherit name;
    value = buildPlug name;
  })
  flakes)
