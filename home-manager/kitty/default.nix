{
  cmn,
  host,
  ...
}:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = if (host == "albrecht") then "12.8"
        else if (host == "loid") then "12" else "12.8";
      font_family = cmn.font;
      copy_on_select = "yes";
      cursor_shape = "block";
      cursor_blink_interval = 0;
      enable_audio_bell = "no";
      shell = "zsh";
      editor = "nvim";
      window_padding_width = 10;
      window_margin_width = 5;
      tab_title_template = "{index}";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      enabled_layouts = "vertical";
      adjust_line_height = "110%";
      allow_remote_control = true;
      listen_on = "unix:@mykitty";
    };
    keybindings = {
      "ctrl+left" = "neighboring_window left";
      "ctrl+up" = "neighboring_window top";
      "ctrl+right" = "neighboring_window right";
      "ctrl+down" = "neighboring_window down";

      "shift+left" = "resize_window narrower";
      "shift+right" = "resize_window wider";
      "shift+up" = "resize_window taller 3";
      "shift+down" = "resize_window shorter 3";
    };
    theme = cmn.scheme.kitty;
  };
}
