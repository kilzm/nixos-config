{ lib, ... }: {
  options.wallpaper = {
    normal = lib.mkOption {
      type = lib.types.path;
      default = ../../../wallpapers/ismail-inceoglu-infinity.jpg;
    };
    flipped = lib.mkOption {
      type = lib.types.path;
      default = ../../../wallpapers/ismail-inceoglu-infinity-flipped.jpg;
    };
  };
}
