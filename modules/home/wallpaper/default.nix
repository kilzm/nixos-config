{ lib, ... }: {
  options.wallpaper = {
    normal = lib.mkOption {
      type = lib.types.path;
      default = ../../../wallpapers/zen-garden.jpg;
    };
    flipped = lib.mkOption {
      type = lib.types.path;
      default = ../../../wallpapers/zen-garden-flipped.jpg;
    };
  };
}
