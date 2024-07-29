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

    theme = spicePkgs.themes.text;
    customColorScheme = {
      accent = "b6b6b6";
      accent-active = "b6b6b6";
      accent-inactive = "121212";
      banner = "b6b6b6";
      border-active = "b6b6b6";
      border-inactive = "535353";
      header = "535353";
      highlight = "1a1a1a";
      main = "121212";
      notification = "4687d6";
      notification-error = "e22134";
      subtext = "b3b3b3";
      text = "FFFFFF";
    };
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
