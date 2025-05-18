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
  ];

  services.joycond.enable = true;
  programs.joycond-cemuhook.enable = true;
}
