{
  flake.modules.nixos.immich.services.immich = {
    enable = true;
    mediaLocation = "/media/photos";
  };
}
