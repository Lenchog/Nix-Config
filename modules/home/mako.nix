{
  flake.modules.homeManager.mako = {
    services.mako = {
      enable = true;
      settings = {
        borderRadius = 5;
        borderSize = 2;
        layer = "overlay";
        height = 200;
        defaultTimeout = 5000;
      };
    };
  };
}
