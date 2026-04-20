{ lib, ... }:
{
  flake.modules.nixos.boot =
    { pkgs, ... }:
    {
      boot = {
        plymouth.enable = true;
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          timeout = lib.mkForce null;
        };
        consoleLogLevel = 0;
        initrd = {
          verbose = false;
          availableKernelModules = [
            "xhci_pci"
            "nvme"
          ];
        };
        kernelParams = [
          "quiet"
          "udev.log_level=0"
        ];
        kernelPackages = pkgs.linuxPackages_latest;
      };
    };
}
