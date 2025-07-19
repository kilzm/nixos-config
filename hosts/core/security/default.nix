{ ... }:
{
  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
}
