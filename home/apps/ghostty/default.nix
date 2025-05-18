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

  programs.ghostty = {
    enable = true;
    settings = rec {
      font-family = config.theming.fonts.mono;

      theme = "nordfox";
      background = "141414";
      background-opacity = 1.0;

      command = "zsh";
      shell-integration = "zsh";
      shell-integration-features = "no-cursor";
      cursor-style = "bar";
      gtk-single-instance = true;

      window-decoration = false;
      confirm-close-surface = false;

      keybind = "ctrl+enter=unbind";
    };
  };
}
