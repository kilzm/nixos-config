{ ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth, nfc, wwan";
    };
  };

}
