{ pkgs, inputs, config, ... }:
let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.dribbblish;
    colorScheme = "Lunar";
  };

  xdg.desktopEntries = {
    spotify = {
      name = "Spotify";
      exec = "spotify";
      icon = "spotify";
      type = "Application";
    };
  };
}
