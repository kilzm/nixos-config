{ border-radius, font-size, sans, mono }:
let br = builtins.toString border-radius;
in /* css */''
  @import '/home/kilianm/.cache/wal/colors-gtk.css';

  * {
    font-family: FontAwesome, ${sans}, ${mono};
    font-size: ${builtins.toString font-size}px;
    padding-top: 0;
    padding-bottom: 0;
  }

  /* main waybar */
  window#waybar {
    /* background: @background-opq; */
    background: rgba(0,0,0,0);
  }

  #workspaces {
    margin: 8px 0px 0px 0px;
    padding: 0px 15px 0px 0px;
    background: @background;
    color: @foreground;
    border-bottom-right-radius: ${br}px;
    border-top-right-radius: ${br}px;
    color: @foreground;
  }

  #workspaces button {
    border-top: 8px solid transparent;
    border-bottom: 3px solid transparent;
    border-radius: 0;
    padding: 0px 6px;
    color: @foreground;
  }

  #workspaces button.active {
    border-bottom: 3px solid @color10;
    color: @color10;
  }

  #workspaces button:hover {
    color: @color9;
    border-bottom: 3px solid @color9;
  }

  #disk.text,
  #cpu.text,
  #temperature,
  #memory.text,
  #pulseaudio.text,
  #battery.text,
  #clock.caltext,
  #clock.clocktext,
  #tray {
    margin: 8px 0px 0px 0px;
    border-top: 4px solid transparent;
    background: @background;
    padding: 0px 15px 0px 5px;
    color: @foreground;
  }

  #custom-logo {
    margin: 8px 0px 0px 20px;
    background: @background;
    color: @color2;
    border-top-left-radius: ${br}px;
    border-bottom-left-radius: ${br}px;
    font-size: ${builtins.toString (font-size + 6)};
    padding: 0px 0px 0px 15px;
  }

  #custom-spotify.icon {
    margin: 8px 0px 0px 20px;
    padding: 0px 5px 0px 15px;
    background: @background;
    color: @color13;
    border-top-left-radius: ${br}px;
    border-bottom-left-radius: ${br}px;
  }

  #custom-spotify.text {
    margin: 8px 0px 0px 0px;
    padding: 0px 15px 0px 0px;
    background: @background;
    color: @foreground;
    border-top-right-radius: ${br}px;
    border-bottom-right-radius: ${br}px;
  }
  
  #clock.calicon {
    margin: 8px 0px 0px 0px;
    padding: 0px 0px 0px 15px;
    color: @color4;
    background: @background;
    border-top-left-radius: ${br}px;
    border-bottom-left-radius: ${br}px;
  }

  #clock.clockicon {
    margin: 8px 0px 0px 0px;
    color: @color4;
    background: @background;
  }

  #clock.clocktext {
    border-top-right-radius: ${br}px;
    border-bottom-right-radius: ${br}px;
  }


  #disk.icon {
    margin: 8px 0px 0px 0px;
    padding: 0px 0px 0px 15px;
    background: @background;
    color: @color4;
    border-top-left-radius: ${br}px;
    border-bottom-left-radius: ${br}px;
  }

  #cpu.icon {
    margin: 8px 0px 0px 0px;
    padding: 0px 0px 0px 15px;
    background: @background;
    color: @color4;
  }

  #cpu.text {
    padding-right: 0px;
  }

  #memory.icon {
    margin: 8px 0px 0px 0px;
    padding: 0px 0px 0px 15px;
    background: @background;
    color: @color4;
  }

  #memory.text {
    border-top-right-radius: ${br}px;
    border-bottom-right-radius: ${br}px;
    margin-right: 20px;
  }

  #pulseaudio.icon {
    margin: 8px 0px 0px 0px;
    padding: 0px 0px 0px 15px;
    background: @background;
    color: @color2;
    border-top-left-radius: ${br}px;
    border-bottom-left-radius: ${br}px;
  }

  #battery.icon {
    margin: 8px 0px 0px 0px;
    padding: 0px 4px 0px 15px;
    background: @background;
    color: @color2;
  }

  #tray {
    margin-right: 20px;
    border-top-right-radius: ${br}px;
    border-bottom-right-radius: ${br}px;
  }
''
