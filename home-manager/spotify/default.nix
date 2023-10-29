{
  pkgs,
  inputs,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Dribbblish;
    colorScheme = "nord-dark";

    enabledExtensions = with spicePkgs.extensions; [
    ];
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