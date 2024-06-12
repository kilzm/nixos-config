{ lib, ... }:
let
  mkThemingOption = { name ? "", pkg ? null, }:
    lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
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
      fonts = lib.mkOption {
        type = lib.types.submodule {
          options = {
            sans = lib.mkOption {
              type = lib.types.str;
              default = "Overpass";
            };
            mono = lib.mkOption {
              type = lib.types.str;
              default = "Iosevka NF";
            };
          };
        };
        default = { };
      };

      kitty = lib.mkOption {
        type = lib.types.str;
        default = "Kanagawa";
      };

      neovim = lib.mkOption {
        type = lib.types.str;
        default = "default";
      };

      gtk = mkThemingOption { };
      cursors = mkThemingOption { };
      icons = mkThemingOption { };
      qt = mkThemingOption { };

      ram = lib.mkOption {
        type = lib.types.str;
        default = "ffffff";
      };
    };
  };
}
