{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}