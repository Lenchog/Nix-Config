{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil.url = "github:oxalica/nil";
    nixos.url = "nixpkgs/nixos-unstable";
    garf.url = "github:lenchog/garf";
    lenchorg = {
      url = "github:lenchog/lenchorg";
      flake = false;
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-tmodloader.url = "github:/andOrlando/nix-tmodloader";
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
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
    } (inputs.import-tree ./modules);
}
