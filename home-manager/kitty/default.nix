{
  cmn,
  host,
  ...
}:

{
  imports = [
    ./${host}.nix
  ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = cmn.font;

      shell = "zsh";
      editor = "nvim";

      enable_audio_bell = "no";

      cursor_shape = "block";
      cursor_blink_interval = 0;
      background_opacity = "0.95";
      background_blur = 20;
      window_padding_width = 10;
      window_margin_width = 5;
      adjust_line_height = "110%";
      enabled_layouts = "vertical";

      tab_title_template = "{index}";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      confirm_os_window_close = 0;

      allow_remote_control = true;
      listen_on = "unix:@mykitty";

      copy_on_select = "yes";
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
