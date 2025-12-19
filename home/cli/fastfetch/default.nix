{pkgs, ...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        separator = "  ";
      };
      logo = {
        source = ./nixos.png;
        type = "kitty";
        height = 10;
        padding.top = 1;
      };
      modules = [
        {
          format = "{1}";
          key = "╭─󰻠";
          keyColor = "red";
          type = "cpu";
        }
        {
          format = "{2}";
          key = "├─󰍛";
          keyColor = "red";
          type = "gpu";
        }
        {
          format = "{1} / {2}";
          key = "╰─󰑭";
          keyColor = "red";
          type = "memory";
        }
        "break"
        {
          key = "╭─";
          keyColor = "yellow";
          type = "shell";
        }
        {
          key = "├─";
          keyColor = "yellow";
          type = "terminal";
        }
        {
          format = "{2}";
          key = "├─";
          keyColor = "yellow";
          type = "terminalfont";
        }
        {
          key = "├─";
          keyColor = "yellow";
          type = "de";
        }
        {
          format = "{1} {5}";
          key = "╰─";
          keyColor = "yellow";
          type = "wm";
        }
        "break"
        {
          format = "{3}";
          key = "╭─";
          keyColor = "green";
          type = "os";
        }
        {
          format = "{1} {2}";
          key = "├─";
          keyColor = "green";
          type = "kernel";
        }
        {
          key = "╰─󰅐";
          keyColor = "green";
          type = "uptime";
        }
      ];
    };
  };
}
