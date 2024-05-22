{ config, ... }:
{
  programs.zathura = {
    enable = true;
    options = with config.colorScheme.palette; {
      default-bg = "#${base00}";
      default-fg = "#${base02}";
      statusbar-fg = "#${base05}";
      statusbar-bg = "#${base00}";
    };
    mappings = {
      u = "scroll half-up";
      d = "scroll half-down";
      D = "toggle_page_mode";
      p = "print";
      R = "rotate";
      r = "reload";
    };
  };

  xdg.mimeApps = {
    defaultApplications."application/pdf" = [ "org.pwmt.zathura.desktop" ];
    associations.added."application/pdf" = [ "org.pwmt.zathura.desktop" ];
  };
}
