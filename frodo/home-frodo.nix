{ inputs, ... }:
{
  home = {
    username = "lenny";
    homeDirectory = "/home/lenny";
    stateVersion = "24.05";
  };
  programs = {
    home-manager.enable = true;
    zellij.enable = true;
  };
  imports = [
    ../home/git.nix
    ../home/zsh.nix
    ../home/helix.nix
    ../home/zellij.nix
  ];
}
