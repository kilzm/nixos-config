{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    windowManagerPatch = false;
    wayland = true;

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

    theme = spicePkgs.themes.fluent;
    colorScheme = "dark";
  };
}
