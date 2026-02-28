{ inputs, self, ... }:
{
  flake.modules.nixos.base =
    { lib, ... }:
    {
      # required for hm module
      programs.zsh.enable = true;
      hardware.enableRedistributableFirmware = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "24.11";
    };
}
