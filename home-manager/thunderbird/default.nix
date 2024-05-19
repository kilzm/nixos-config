{ lib, pkgs, config, inputs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.default = { isDefault = true; };
  };
}
