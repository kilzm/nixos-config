{ lib, ... }:
{
  programs.kitty.settings = {
    font_size = "12.5";
    background_opacity = lib.mkForce "0.9";
  };
}
