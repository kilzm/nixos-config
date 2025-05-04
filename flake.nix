{
  description = "Kilian's NixOS coniguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };

    astal = {
      url = "github:Aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
      inputs.astal.inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rycee-nur = {
      url = "gitlab:rycee/nur-expressions";
      flake = false;
    };

    # Neovim Plugins
    neomodern-nvim = {
      url = "github:cdmill/neomodern.nvim/843698e7e3e6199da3e7c89ab9b3d8807d7be69a";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            qt6Packages = prev.qt6Packages.overrideScope (_: kprev: {
              qt6gtk2 = kprev.qt6gtk2.overrideAttrs (_: {
                version = "0.5-unstable-2025-03-04";
                src = final.fetchFromGitLab {
                  domain = "opencode.net";
                  owner = "trialuser";
                  repo = "qt6gtk2";
                  rev = "d7c14bec2c7a3d2a37cde60ec059fc0ed4efee67";
                  hash = "sha256-6xD0lBiGWC3PXFyM2JW16/sDwicw4kWSCnjnNwUT4PI=";
                };
              });
            });
          })
        ];
      };
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
            inputs.chaotic.nixosModules.default
          ];
        };

        loid = lib.nixosSystem {
          specialArgs = {
            host = "loid";
            inherit inputs outputs self;
          };
          modules = [
            ./hosts/loid
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
