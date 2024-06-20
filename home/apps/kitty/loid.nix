{ lib, ... }:
{
  programs.kitty.settings = {
    font_size = 14;
    background_opacity = lib.mkForce "0.9";
  };
}
