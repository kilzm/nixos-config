{
  description = "Kilian's NixOS coniguration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
	  stable.url = github:nixos/nixpkgs/23.05;
    nix-colors.url = github:Misterio77/nix-colors;
    spicetify-nix = {
      url = github:the-argus/spicetify-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rycee-nur = {
      url = gitlab:rycee/nur-expressions;
      flake = false;
    };
    nordic-theme = {
      url = github:EliverLara/Nordic;
      flake = false;
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nvim
    headlines-nvim = { url = github:lukas-reineke/headlines.nvim; flake = false; };
    nvim-tree = { url = github:nvim-tree/nvim-tree.lua; flake = false; };
    startup-nvim = { url = github:startup-nvim/startup.nvim; flake = false; };
    error-lens-nvim = { url = github:chikko80/error-lens.nvim; flake = false; };
    nord-nvim-alt = { url = github:gbprod/nord.nvim; flake = false; };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };
    overlay = import ./overlay.nix;
    pkgs = import nixpkgs {
      inherit system config;
    };
    inherit (nixpkgs) lib;
    cmn = import ./common.nix { inherit inputs pkgs lib; };
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = { inherit inputs outputs cmn; };
        modules = [ 
          ./nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      kilianm = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs outputs cmn; };
        modules = [ 
          ./home-manager/home.nix
        ];
      };
    };
  };
}
