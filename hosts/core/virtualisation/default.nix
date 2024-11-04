{ inputs, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.extraGroups.docker.members = [ "kilianm" ];

  services.xserver.videoDrivers = [ "vmware" ];

  virtualisation.vmware = {
    host = {
      enable = true;
    };
    guest = {
      enable = true;
    };
  };
}
