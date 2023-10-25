{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

{
  programs.wlogout = let
    c = config.colorScheme.colors;
    iconDir = "apps/wlogout/icons";
    shutdown = ./${iconDir}/shutdown.png;
    suspend = ./${iconDir}/suspend.png;
    lock = ./${iconDir}/lock.png;
    hibernate = ./${iconDir}/hibernate.png;
    reboot = ./${iconDir}/reboot.png;
    logout = ./${iconDir}/logout.png;
  in {
    enable = true;
    style = ''
      * {
        font-family: "GohuFont 11 Nerd Font", FontAwesome;
        background-image: none;
        transition: 20ms;
      }

      window {
        background-color: rgba(12, 12, 12, 0.1);
      }

      button {
        color: #${c.base04};
        font-size: 30px;

        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;

        border-style: solid;
        background-color: rgba(12, 12, 12, 0.3);
        border: 3px solid #${c.base0D};

        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2) 0 6px 20px 0 rgba (0, 0, 0, 0.19);
      }

      button:focus,
      button:active,
      button:hover {
        color:  #${c.base0D};
        background-color: rgba(12, 12, 12, 0.5);
        border: 3px solid #${c.base0D};
      }

      #lock {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${lock}"));
      }

      #logout {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${logout}"));
      }

      #suspend {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${suspend}"));
      }

      #hibernate {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${hibernate}"));
      }

      #reboot {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${reboot}"));
      }

      #shutdown {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${shutdown}"));
      }
    '';
  };
}