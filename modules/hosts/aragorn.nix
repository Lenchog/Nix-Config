{
  inputs,
  self,
  config,
  ...
}:
{
  flake = {

    nixosConfigurations.aragorn = inputs.nixpkgs.lib.nixosSystem {
      modules = with self.modules.nixos; [
        base
        gui
        boot
        nix-conf
        users
        homeManager
        networking
        syncthing
        aragorn
        kanata
        sops
        nh
      ];
    };
    modules.nixos.aragorn = {
      boot = {
        initrd = {
          kernelModules = [ "nvidia" ];
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "nvme"
            "usbhid"
          ];
        };
        kernelParams = [
          "nvidia-drm.modeset=1"
          "kvm-amd"
        ];
      };
      hardware.nvidia = {
        open = false;
        modesetting.enable = true;
        # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      };
      services.xserver.videoDrivers = [ "nvidia" ];
      networking.hostName = "aragorn";
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/ce6b7dd2-5df7-49b7-bd87-45c6c86ee0fb";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/4239-6CA4";
        fsType = "vfat";
      };
    };
  };
}
