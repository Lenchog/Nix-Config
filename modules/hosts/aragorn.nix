{
  inputs,
  self,
  config,
  ...
}:
{
  flake.nixosConfigurations.aragorn = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.aragorn
      self.modules.nixos.main
      self.modules.nixos.gui
    ];
  };
  flake.modules.nixos.aragorn = {
    boot = {
      initrd.kernelModules = [ "nvidia" ];
      kernelParams = [ "nvidia-drm.modeset=1" ];
    };
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    networking.hostName = "aragorn";
  };
}
