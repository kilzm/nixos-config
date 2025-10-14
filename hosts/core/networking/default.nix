{host, pkgs, ...}: {
  networking = {
    nftables.enable = true;
    hostName = host;
    hosts = {
      "192.168.178.39" = [
        "BRN30055C28FBC7.local"
        "BRN30055C28FBC7"
      ];
    };
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
    firewall = {
      checkReversePath = false;
    };
  };
}
