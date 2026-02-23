{
  flake.modules.nixos.base = {
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.11";
  };
}
