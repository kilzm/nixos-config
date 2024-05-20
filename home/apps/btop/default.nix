{ ... }: {
  programs.btop = {
    enable = true;
    settings = {
      rounded_corners = true;
      theme_background = false;
    };
  };
}
