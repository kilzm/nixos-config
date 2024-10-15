{ pkgs, inputs, ... }:
let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    windowManagerPatch = true;

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      history
      fullAppDisplay
      seekSong
    ];

    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      ncsVisualizer
    ];

    theme = spicePkgs.themes.dribbblish;
    colorScheme = "lunar";
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
