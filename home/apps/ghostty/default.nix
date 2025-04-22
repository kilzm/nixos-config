{ config, host, pkgs, ... }:
let
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

  programs.ghostty = {
    enable = true;
    settings = {
      config-file = "../../.cache/wal/colors-ghostty";
      font-family = config.theming.fonts.mono;

      command = "zsh";
      shell-integration = "zsh";
      shell-integration-features = "no-cursor";
      cursor-style = "bar";
      # cursor-style-blink = false;
      gtk-single-instance = true;

      window-decoration = false;
      background-opacity = 0.92;
      confirm-close-surface = false;

      keybind = "ctrl+enter=unbind";
    };
  };
}
