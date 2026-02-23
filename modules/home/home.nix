{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules = {
    nixos.homeManager = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager.users.lenny.imports = with self.modules.homeManager; [
        base
        packages
        eww
        fastfetch
        firefox
        foot
        git
        helix
        lf
        niri
        mako
        stylix
        wofi
        zoxide
        zsh
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
