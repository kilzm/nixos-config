{ pkgs, host, ... }: {
  programs.pywal16.templates.colors-cava = ''
    [color]
    gradient=1
    gradient_color_1='{color1}'
    gradient_color_2='{color2}'
    gradient_color_3='{color3}'
    gradient_color_4='{color4}'
    gradient_color_5='{color5}'
    gradient_count=5

    [general]
    sensitivity=70
    framerate=${if host == "albrecht" then "165" else "60"}
  '';


  programs.cava = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = pkgs.cava.name;
      paths = [ pkgs.cava ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = "wrapProgram $out/bin/cava --add-flags '-p ~/.cache/wal/colors-cava'";
    };
  };
}
