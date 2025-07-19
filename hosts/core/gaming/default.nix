{pkgs, ...}: {
  programs.steam.enable = true;

  programs.gamescope.enable = true;
  programs.steam.gamescopeSession.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          pango
          libthai
          harfbuzz
        ];
    };
  };
  environment.systemPackages = with pkgs; [
    gamemode
    mangohud
    protontricks
    vulkan-tools
    sunshine
  ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  services.joycond.enable = true;
  programs.joycond-cemuhook.enable = true;
}
