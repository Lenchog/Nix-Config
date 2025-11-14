{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil.url = "github:oxalica/nil";
    nixos.url = "nixpkgs/nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
    garf.url = "github:lenchog/garf";
    lenchorg = {
      url = "github:lenchog/lenchorg";
      flake = false;
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    musnix.url = "github:musnix/musnix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    nix-topology.url = "github:oddlama/nix-topology";
  };
  outputs =
    {
      nixpkgs,
      self,
      deploy-rs,
      ...
    }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          inputs.nix-topology.overlays.default
        ];
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      topology.x86_64-linux = import inputs.nix-topology {
        inherit pkgs;
        modules = [
          { nixosConfigurations = self.nixosConfigurations; }
        ];
      };
      deploy.nodes.frodo = {
        hostname = "frodo";
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.frodo;
        };
      };
      nixosConfigurations = {
        legolas = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs;
            gui = true;
            laptop = true;
            desktop = false;
            games = true;
            server = false;
            vm = false;
            impermanence = false;
          };
          modules = [ ./configuration.nix ];
        };
        aragorn = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs;
            gui = true;
            laptop = false;
            desktop = true;
            games = true;
            server = false;
            vm = false;
            impermanence = false;
          };
          modules = [
            ./configuration.nix
          ];
        };
        /*
          vm = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs system;
              gui = false;
              laptop = false;
              desktop = false;
              games = false;
              server = false;
              vm = true;
              impermanence = true;
            };
            modules = [
              ./configuration.nix
            ];
          };
        */
        frodo = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            gui = false;
            laptop = false;
            desktop = false;
            games = false;
            server = true;
            impermanence = false;
            vm = false;
          };
          modules = [
            ./configuration.nix
          ];
        };
      };
    };
}
