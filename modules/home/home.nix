{
  flake.modules.homeManager.base = {
    programs.home-manager.enable = true;
    home = {
      username = "lenny";
      homeDirectory = "/home/lenny";
      stateVersion = "24.05";
    };
  };
}
