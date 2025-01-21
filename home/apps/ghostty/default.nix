{ config, host, ... }:
{
  imports = [
    ./${host}.nix
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      config-file = "../../.cache/wal/colors-ghostty";
      font-family = config.theming.fonts.mono;

      command = "zsh";
      shell-integration = "zsh";
      shell-integration-features = "no-cursor";
      cursor-style = "block";
      cursor-style-blink = false;
      gtk-single-instance = true;

      window-decoration = false;
      background-opacity = 0.92;
      confirm-close-surface = false;

      keybind = "ctrl+enter=unbind";
    };
  };
}
