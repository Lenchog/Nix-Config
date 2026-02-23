{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Lenchog";
        email = "lennyescott@gmail.com";
      };
    };
  };
}
