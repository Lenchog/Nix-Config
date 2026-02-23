{ inputs, self, ... }:
{
  flake.modules.nixos.base =
    { lib, ... }:
    {
      programs.zsh.enable = true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "24.11";
    };
}
