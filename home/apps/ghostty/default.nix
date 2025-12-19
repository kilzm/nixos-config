{
  config,
  host,
  pkgs,
  ...
}: let
  xterm = pkgs.writeShellScriptBin "xterm" ''
    ${pkgs.ghostty}/bin/ghostty "$@"
  '';
in {
  imports = [
    ./${host}.nix
  ];

  home.packages = [
    xterm
  ];

  xdg.configFile."ghostty/themes/nordfox".text = ''
    background = #2e3440
    foreground = #cdcecf
    selection-background = #3e4a5b
    selection-foreground = #cdcecf
    cursor-color = #cdcecf

    # normal
    palette = 0=#3b4252
    palette = 1=#bf616a
    palette = 2=#a3be8c
    palette = 3=#ebcb8b
    palette = 4=#81a1c1
    palette = 5=#b48ead
    palette = 6=#88c0d0
    palette = 7=#e5e9f0

    # bright
    palette = 8=#465780
    palette = 9=#d06f79
    palette = 10=#b1d196
    palette = 11=#f0d399
    palette = 12=#8cafd2
    palette = 13=#c895bf
    palette = 14=#93ccdc
    palette = 15=#e7ecf4

    # extended colors
    palette = 16=#c9826b
  '';

  programs.ghostty = {
    enable = true;
    settings = rec {
      font-family = config.theming.fonts.mono;

      theme = "nordfox";
      background = "141414";
      background-opacity = 0.93;

      command = "zsh";
      shell-integration = "zsh";
      shell-integration-features = "no-cursor";
      cursor-style = "bar";
      gtk-single-instance = true;

      window-decoration = false;
      confirm-close-surface = false;

      mouse-scroll-multiplier = 1;

      keybind = "ctrl+enter=unbind";
    };
  };
}
