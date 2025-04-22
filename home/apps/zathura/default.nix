{ pkgs, ... }:
{
  programs.pywal16.templates.zathurarc = ''
    set default-bg "{background}"
    set default-fg "{foreground}"
    set statusbar-bg "{background}"
    set statusbar-fg "{color5}"
    map D toggle_page_mode
    map R rotate
    map d scroll half-down
    map p print
    map r reload
    map u scroll half-up
  '';

  programs.zathura = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = pkgs.zathura.name;
      paths = [ pkgs.zathura ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = "wrapProgram $out/bin/zathura --add-flags '--config-dir=~/.cache/wal'";
    };
  };


  xdg.mimeApps = {
    defaultApplications."application/pdf" = [ "org.gnome.Papers.desktop" ];
    associations.added."application/pdf" = [ "org.gnome.Papers.desktop" ];
  };
}
