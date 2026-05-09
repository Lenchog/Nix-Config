{ inputs, pkgs, ... }:
{
  flake.modules.homeManager.slippi =
    { pkgs, ... }:
    {
      imports = [ inputs.slippi-nix.homeManagerModules.default ];
      slippi-launcher = {
        enable = true;
        isoPath = "/home/lenny/melee/isos/ANIMELEE-M-EX.iso";
        launchMeleeOnPlay = true;
      };
    };
}
