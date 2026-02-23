{ inputs, ... }:
{
  flake.modules.nixos.nh =
    { ... }:
    {
      programs.nh = {
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/lenny/nix-config";
      };
    };
}
