{ inputs, pkgs, ... }:
let
  mkFg = fg: { fg = "${fg}"; };
  mkBg = bg: { bg = "${bg}"; };
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
        cwd = mkFg "blue";
        hovered = mkBoth "white" "blue";
        preview_hovered = (mkBoth "white" "blue") // { blink = true; };
        find_keyword = (mkFg "white") // { bold = true; underline = true; };
        find_position = (mkFg "white") // { bold = true; };
        marker_marked = mkSame "blue";
        marker_selected = mkSame "magenta";
        marker_copied = mkSame "yellow";
        marker_cut = mkSame "red";
        tab_active = mkBoth "black" "blue";
        tab_inactive = mkBoth "gray" "black";
        border_style = mkFg "darkgray";
      };

      status = {
        separator_open = "";
        separator_close = "";
        separator_style = mkSame "black";

        mode_normal = mkBoth "black" "blue";
        mode_select = mkBoth "black" "magenta";
        mode_unset = mkBoth "black" "yellow";

        progress_label = mkBg "black";
        progress_normal = mkBg "black";
        progress_error = mkBg "black";
      };

      select = {
        border = mkSame "blue";
        active = mkSame "yellow";
        inactive = mkSame "gray";
      };

      input = {
        border = mkFg "blue";
        title = mkFg "gray";
        value = mkFg "gray";
        selected = mkBg "gray";
      };

      completion = {
        border = mkFg "blue";
        active = mkBoth "yellow" "gray";
        inactive = mkFg "gray";
      };

      tasks = {
        border = mkFg "blue";
        title = mkFg "gray";
        hovered = mkBoth "gray" "gray";
      };

      which = {
        mask = mkBg "black";
        cand = mkFg "magenta";
        rest = mkFg "gray";
        desc = mkFg "gray";
        separator_style = mkFg "darkgray";
      };

      help = {
        on = mkFg "yellow";
        run = mkFg "magenta";
        desc = mkFg "gray";
        hovered = mkBoth "gray" "gray";
        footer = mkFg "gray";
      };

      # filetype = {
      #   rules =
      #     let
      #       mkRule = mime: fg: {
      #         inherit mime;
      #         fg = "${fg}";
      #       };
      #     in
      #     [ (mkRule "*" "gray") ];
      # };
      #
    };
  };
}
