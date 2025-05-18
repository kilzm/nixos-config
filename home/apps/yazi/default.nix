{
  inputs,
  pkgs,
  ...
}: let
  mkFg = fg: {fg = "${fg}";};
  mkBg = bg: {bg = "${bg}";};
  mkBoth = fg: bg: (mkFg fg) // (mkBg bg);
  mkSame = c: mkBoth c c;
in {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
            orphan = true;
          }
        ];
      };
    };
  };
}
