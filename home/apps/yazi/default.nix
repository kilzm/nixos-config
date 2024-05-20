{ config, inputs, pkgs, ... }:
let
  c = config.colorScheme.palette;
  mkFg = fg: { fg = "#${fg}"; };
  mkBg = bg: { bg = "#${bg}"; };
  mkBoth = fg: bg: (mkFg fg) // (mkBg bg);
  mkSame = c: mkBoth c c;
in
{
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.yazi;
    enableZshIntegration = true;

    settings = {
      opener = {
        edit = [{
          run = ''nvim "$@"'';
          block = true;
          orphan = true;
        }];
      };
    };

    theme = {
      manager = {
        cwd = mkFg c.base0D;
        hovered = mkBoth c.base05 c.base03;
        preview_hovered = (mkBoth c.base05 c.base00) // { blink = true; };
        find_keyword = (mkFg c.base0B) // { bold = true; };
        find_position = mkFg c.base05;
        marker_marked = mkSame c.base0D;
        marker_selected = mkSame c.base0C;
        marker_copied = mkSame c.base0E;
        marker_cut = mkSame c.base08;
        tab_active = mkBoth c.base00 c.base0D;
        tab_inactive = mkBoth c.base05 c.base01;
        border_style = mkFg c.base04;
      };

      status = {
        separator_open = "";
        separator_close = "";
        separator_style = mkSame c.base00;

        mode_normal = mkBoth c.base00 c.base0D;
        mode_select = mkBoth c.base00 c.base0C;
        mode_unset = mkBoth c.base00 c.base0E;

        progress_label = mkBg c.base00;
        progress_normal = mkBg c.base00;
        progress_error = mkBg c.base00;
      };

      select = {
        border = mkSame c.base0D;
        active = mkSame c.base0E;
        inactive = mkSame c.base05;
      };

      input = {
        border = mkFg c.base0D;
        title = mkFg c.base05;
        value = mkFg c.base05;
        selected = mkBg c.base03;
      };

      completion = {
        border = mkFg c.base0D;
        active = mkBoth c.base0E c.base03;
        inactive = mkFg c.base05;
      };

      tasks = {
        border = mkFg c.base0D;
        title = mkFg c.base05;
        hovered = mkBoth c.base05 c.base03;
      };

      which = {
        mask = mkBg c.base02;
        cand = mkFg c.base0C;
        rest = mkFg c.base0F;
        desc = mkFg c.base05;
        separator_style = mkFg c.base04;
      };

      help = {
        on = mkFg c.base0E;
        run = mkFg c.base0C;
        desc = mkFg c.base05;
        hovered = mkBoth c.base05 c.base03;
        footer = mkFg c.base05;
      };

      filetype = {
        rules =
          let
            mkRule = mime: fg: {
              inherit mime;
              fg = "#${fg}";
            };
          in
          [ (mkRule "*" c.base05) ];
      };

      icon = {
        prepend_rules = [
          ({
            name = "*/";
            text = " ";
          } // (mkFg c.base0D))
        ];
      };
    };
  };
}
