{
  inputs,
  pkgs,
  config,
  ...
}:
{
  flake.modules.nixos.garf =
    { config, pkgs, ... }:
    {
      systemd.services.garf = {
        description = "AKL leaderboard bot";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        enable = true;
        serviceConfig = {
          ExecStart = "${inputs.garf.packages.${pkgs.system}.default}/bin/garf";
          user = "lenny";
          StateDirectory = "garf";
          restart = "always";
          EnvironmentFile = config.sops.secrets."garf_key".path;
        };
      };
    };
}
