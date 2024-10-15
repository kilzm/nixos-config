{ pkgs, ... }:
{
  programs.steam.enable = true;
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
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
}

