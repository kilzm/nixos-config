{ ... }:
{
  programs.ghostty = {
    settings = {
      font-size = 13;
      adjust-cell-height = "20%";
      window-padding-x = 8;
      window-padding-y = 8;
    };
  };
  # xdg.configFile."ghostty/host-config".text = ''
  #   font-size = 13
  #   adjust-cell-height = 20%
  #   window-padding-x = 8
  #   window-padding-y = 8
  # '';
}
