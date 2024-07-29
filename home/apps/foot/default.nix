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
        shell = "zsh";
      };
    };
  };
}
