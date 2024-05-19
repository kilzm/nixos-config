{ border-radius, font-size, font, palette, hexToRGBString }:
let
  br = builtins.toString border-radius;
in ''
      * {
        font-family: FontAwesome, "${font}";
        font-size: ${builtins.toString font-size}px;
        font-weight: 600;
      }
      
      /* main waybar */
      window#waybar {
        background: rgba(${hexToRGBString ", " palette.base01}, 0);
      }

      #custom-logo,
      #workspaces,
      #custom-spotify,
      #disk,
      #cpu,
      #memory,
      #battery,
      #pulseaudio,
      #clock,
      #tray {
        background: rgba(${hexToRGBString ", " palette.base00}, 0.95);
        padding: 0px 15px;
        color: #${palette.base05};
      }

      #custom-logo {
        border-top-left-radius: ${br}px;
        border-bottom-left-radius: ${br}px;
        font-size: ${builtins.toString (font-size + 6)};
        padding: 0px 0px 0px 5px;
      }
      
      #workspaces {
        padding: 0px 5px 0px 0px;
        border-top-right-radius: ${br}px;
        border-bottom-right-radius: ${br}px;
        color: #${palette.base05};
      }
      
      #workspaces button {
        border-bottom: 1.5px solid transparent;
        border-radius: 0;
        color: #${palette.base05};
      }
      
      #workspaces button.active {
        border-bottom: 1.5px solid #${palette.base0D};
        color: #${palette.base0D};
      }
      
      #workspaces button:hover {
        background: rgba(256, 256, 256, 0.2);
      }
      
      #custom-spotify {
        margin: 0px 20px;
        padding: 0px 15px;
        border-radius: ${br}px;
        color: #${palette.base05};
      }
      
      
      #clock {
        border-radius: ${br}px;
        padding: 0px 20px;
        color: #${palette.base05};
      }
      
      #disk {
        border-top-left-radius: ${br}px;
        border-bottom-left-radius: ${br}px;
        color: #${palette.base0F}
      }
      
      #cpu {
        color: #${palette.base0E};
      }
      
      #memory {
        border-top-right-radius: ${br}px;
        border-bottom-right-radius: ${br}px;
        margin-right: 20px;
        color: #${palette.base0D}
      }
      
      #pulseaudio {
        border-top-left-radius: ${br}px;
        border-bottom-left-radius: ${br}px;
        color: #${palette.base0C};
      }
      
      #battery {
        color: #${palette.base0B}
      }
      
      #tray {
        border-top-right-radius: ${br}px;
        border-bottom-right-radius: ${br}px;
      }
      

''