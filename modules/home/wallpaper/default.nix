{ lib, ... }:

{
  options.wallpaper = {
    normal = lib.mkOption {
      type = lib.types.path;
      default = ../../../wallpapers/pine-mountains.png;
    };
    flipped = lib.mkOption {
      type = lib.types.path;
      default = ../../../wallpapers/pine-mountains-flipped.png;
    };
  };
}
