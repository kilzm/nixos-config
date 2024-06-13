{ config, inputs, pkgs, ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock [L]";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout [E]";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown [S]";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot [R]";
        keybind = "r";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend [Z]";
        keybind = "z";
      }
    ];
    style = import ./css.nix { 
    font = config.theming.fonts.sans;
      inherit pkgs;
      inherit (config.colorScheme) palette;
    };
  };
}
