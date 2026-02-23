{
  inputs,
  self,
  nixpkgs,
  ...
}:
let
  nix = self.modules.nixos;
  hm = self.modules.homeManager;
in
{
  flake = {
    nixosConfigurations.legolas = inputs.nixpkgs.lib.nixosSystem {
      modules = with nix; [
        base
        gui
        boot
        homeManager
        networking
        syncthing
        legolas
        kanata
        sops
        nh
      ];
    };
    modules.nixos.legolas =
      { pkgs, ... }:
      {
        networking.hostName = "legolas";

        powerManagement = {
          enable = true;
          powertop.enable = true;
        };
        services = {
          tlp = {
            enable = true;
            settings = {
              CPU_SCALING_GOVERNOR_ON_BAT = "balanced";
            };
          };
          system76-scheduler.settings.cfsProfiles.enable = true;
        };
      };
  };
}
