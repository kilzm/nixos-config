{ lib, ... }:
let
  mkThemingOption = { name ? "", pkg ? null, }:
    lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.string;
            default = name;
          };

          package = lib.mkOption {
            type = lib.types.package;
            default = pkg;
          };
        };
      };
    };
in
{
  options = {
    theming = {
      font = lib.mkOption {
        type = lib.types.string;
        default = "Iosevka Nerd Font";
      };

      kitty = lib.mkOption {
        type = lib.types.string;
        default = "Kanagawa";
      };

      neovim = lib.mkOption {
        type = lib.types.string;
        default = "default";
      };

      gtk = mkThemingOption { };
      cursors = mkThemingOption { };
      icons = mkThemingOption { };
      qt = mkThemingOption { };

      ram = lib.mkOption {
        type = lib.types.string;
        default = "ffffff";
      };
    };
  };
}
