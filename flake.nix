{
  description = "Kilian's NixOS coniguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:Misterio77/nix-colors";

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rycee-nur = {
      url = "gitlab:rycee/nur-expressions";
      flake = false;
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    pyprland = { url = "github:hyprland-community/pyprland"; };
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };
    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpicker = { url = "github:hyprwm/hyprpicker"; };

    yazi.url = "github:sxyazi/yazi";

    nordic-gtk = {
      url = "github:EliverLara/Nordic";
      flake = false;
    };
    kanagawa-gtk = {
      url = "github:Fausto-Korpsvart/Kanagawa-GKT-Theme";
      flake = false;
    };

    # Neovim Plugins
    nvim-tree = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };
    error-lens-nvim = {
      url = "github:chikko80/error-lens.nvim";
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
            inherit inputs outputs;
            host = "albrecht";
          };
          modules = [ ./hosts/albrecht ];
        };

        loid = lib.nixosSystem {
          specialArgs = {
            host = "loid";
            inherit inputs outputs;
          };
          modules = [ ./hosts/loid ];
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
