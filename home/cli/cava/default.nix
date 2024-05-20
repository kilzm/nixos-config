{ config, host, ... }: {
  imports = [ ./${host}.nix ];

  programs.cava = {
    enable = true;
    settings = {
      general = { sensitivity = 70; };
      color = with config.colorScheme.palette; {
        gradient = 1;
        gradient_count = 4;
        gradient_color_1 = "'#${base0E}'";
        gradient_color_2 = "'#${base0C}'";
        gradient_color_3 = "'#${base0D}'";
        gradient_color_4 = "'#${base0F}'";
      };
    };
  };
}
