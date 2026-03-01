{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules = {
    nixos.homeManagerFrodo = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager.users.lenny.imports = with self.modules.homeManager; [
        base
        git
        zsh
        helix
        zoxide
      ];
    };
    homeManager.base = {
      programs.home-manager.enable = true;
      home = {
        username = "lenny";
        homeDirectory = "/home/lenny";
        stateVersion = "24.05";
      };
    };
  };
}
