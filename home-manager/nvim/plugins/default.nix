{ inputs, pkgs }:

let
  flakes = [
    "headlines-nvim"
    "nvim-tree"
    "startup-nvim"
    "error-lens-nvim"
    "nord-nvim-alt"
  ];
  buildPlug = name:
    pkgs.vimUtils.buildVimPlugin {
      pname = name;
      version = "master";
      src = builtins.getAttr name inputs;
    };
in
  builtins.listToAttrs (map (name: {
    inherit name;
    value = buildPlug name;
  }) flakes)
