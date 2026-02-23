{ lib, pkgs, ... }:
{
  flake.modules.nixos.boot =
    { pkgs, ... }:
    {
      boot = {
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
        kernelPackages = pkgs.linuxPackages_zen;
      };
      console = {
        earlySetup = true;
        font = "${pkgs.spleen}/share/consolefonts/spleen-16x32.psfu";
        packages = with pkgs; [ spleen ];
      };
    };
}
