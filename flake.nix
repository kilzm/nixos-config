{
  description = "Kilian's NixOS coniguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
      inputs.astal.inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:Aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
    };

    hypridle = {
      url = "github:hyprwm/Hypridle";
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

    wezterm.url = "github:wez/wezterm?dir=nix";

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
    mellifluous-nvim = {
      url = "github:ramojus/mellifluous.nvim";
      flake = false;
    };
    neomodern-nvim = {
      url = "github:cdmill/neomodern.nvim/843698e7e3e6199da3e7c89ab9b3d8807d7be69a";
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

      devShells.${system}.default = inputs.agsv2.devShells.${system}.default;

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
