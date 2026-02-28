{ inputs, self, ... }:
{
  flake.modules.nixos.base =
    { pkgs, lib, ... }:
    {
      nix.package = pkgs.lixPackageSets.stable.lix;
      # required for hm module
      programs.zsh.enable = true;
      hardware.enableRedistributableFirmware = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "24.11";
    };
}
