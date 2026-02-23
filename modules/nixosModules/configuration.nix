{
  flake.modules.nixos.base = {
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.11";
    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
