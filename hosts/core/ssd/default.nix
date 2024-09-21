{ ... }:
{
  services.fstrim.enable = true;

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
}
