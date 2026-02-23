{
  flake.modules.nixos.syncthing = {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      settings.gui.insecureSkipHostcheck = true;
    };
  };
}
