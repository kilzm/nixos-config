{ inputs, pkgs }:

let
  flakes = [
    "headlines-nvim"
    "nvim-tree"
    "error-lens-nvim"
    "nord-nvim-alt"
    "flash-nvim"
    "typst-vim"
    "nordic-nvim"
    "odin-vim"
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
