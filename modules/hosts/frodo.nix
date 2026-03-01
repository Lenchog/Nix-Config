{
  nixpkgs,
  inputs,
  self,
  config,
  ...
}:
{
  flake = {
    nixosConfigurations.frodo = inputs.nixpkgs.lib.nixosSystem {
      modules = with self.modules.nixos; [
        base
        sops
        boot
        networking
        nix-conf
        syncthing
        users
        frodo
        blocky
        garf
        homeManagerFrodo
        minecraft
        networkingFrodo
        restic
        searx
        vaultwarden
        # grafana
        # immich
      ];
    };
    modules.nixos.frodo = {
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/c97efa2e-8ced-4629-a95d-2b7ecde98bf0";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1999-2782";
        fsType = "vfat";
      };
      services = {
        openssh = {
          enable = true;
          ports = [ 2121 ];
          settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
          };
        };
        fail2ban.enable = true;
      };
    };
    networking.hostname = "frodo";
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
    ];
    boot.kernelModules = [ "kvm-intel" ];
    hardware.cpu.intel.updateMicrocode = true;
    sops.secrets = {
      desec-token = {
        owner = "acme";
      };
    };
  };
}
