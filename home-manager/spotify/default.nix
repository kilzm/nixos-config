{
  pkgs,
  inputs,
  config,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Dribbblish;
    colorScheme = "custom";
    customColorScheme = with config.colorScheme.colors; {
      text = base05;
      subtext = base06;
      sidebar-text = base06;
      main = base00;
      sidebar = base01;
      player = base00;
      card = base00;
      shadow = base01;
      selected-row = base0D;
      button = base07;
      button-active = base07;
      button-disabled = base0E;
      tab-active = base03;
      notification = base0D;
      notification-error = base08;
      misc = base07;
    };

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
