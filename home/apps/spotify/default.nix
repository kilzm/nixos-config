{ pkgs, inputs, config, ... }:
let spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  programs.spicetify = {
    enable = true;
    sidebarConfig = true;
    theme = spicePkgs.themes.Matte;
    colorScheme = "Gray-Dark3";
  };

  xdg.desktopEntries = {
    spotify = {
      name = "Spotify";
      exec = "spotify";
      icon = "spotify";
      type = "Application";
    };
  };

  imports = [ inputs.spicetify-nix.homeManagerModule ];
}
