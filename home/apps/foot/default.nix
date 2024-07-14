{ host, ... }:
{
  imports = [
    ./${host}.nix
  ];

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        include = "~/.cache/wal/colors-foot.ini";
        dpi-aware = "yes";
        shell = "zsh";
        pad = "8x8";
      };
      colors = {
        alpha = 0.9;
      };
    };
  };
}
