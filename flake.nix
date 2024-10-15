{
  description = "Kilian's NixOS coniguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub.url = "github:Lxtharia/minegrub-theme";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rycee-nur = {
      url = "gitlab:rycee/nur-expressions";
      flake = false;
    };

    waypaper = {
      url = "github:anufrievroman/waypaper";
      flake = false;
    };

    yazi.url = "github:sxyazi/yazi";

    # Neovim Plugins
    nvim-tree = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };
    error-lens-nvim = {
      url = "github:chikko80/error-lens.nvim";
      flake = false;
    };
    pywal16-nvim = {
      url = "github:uZer/pywal16.nvim";
      flake = false;
    };
    mellifluous-nvim = {
      url = "github:ramojus/mellifluous.nvim";
      flake = false;
    };
    neomodern-nvim = {
      url = "github:cdmill/neomodern.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      inherit (nixpkgs) lib;
    in
    {
      packages.${system} = import ./pkgs { inherit pkgs; };

      formatter.${system} = pkgs.nixpkgs-fmt;

      homeManagerModules = import ./modules/home;

      nixosConfigurations = {
        albrecht = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self;
            host = "albrecht";
          };
          modules = [
            ./hosts/albrecht
            inputs.minegrub.nixosModules.default
          ];
        };

        loid = lib.nixosSystem {
          specialArgs = {
            host = "loid";
            inherit inputs outputs self;
          };
          modules = [
            ./hosts/loid
            inputs.minegrub.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        "kilianm@albrecht" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            host = "albrecht";
            inherit inputs outputs self;
          };
          modules = [ ./home self.homeManagerModules.all ];
        };

        "kilianm@loid" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            host = "loid";
            inherit inputs outputs self;
          };
          modules = [ ./home self.homeManagerModules.all ];
        };
      };
    };
}
