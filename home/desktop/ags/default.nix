{ config
, inputs
, pkgs
, ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    bun
    dart-sass
  ];

  programs.ags = {
    enable = true;
    configDir = ./.;
  };

  xdg.configFile."agsconfig.json".text = builtins.toJSON {
    font = config.theming.fonts.sans;
    transition = 200;
  };
  # builtins.toJSON
}
