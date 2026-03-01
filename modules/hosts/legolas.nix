{
  inputs,
  self,
  nixpkgs,
  ...
}:
{
  flake = {
    nixosConfigurations.legolas = inputs.nixpkgs.lib.nixosSystem {
      modules = with self.modules.nixos; [
        base
        gui
        boot
        fileSystems
        nix-conf
        users
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
