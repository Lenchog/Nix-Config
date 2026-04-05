{
  inputs,
  self,
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
        homeManagerServer
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
      services.minecraft-servers.servers.cms-0.enable = true;
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/c97efa2e-8ced-4629-a95d-2b7ecde98bf0";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1999-2782";
        fsType = "vfat";
      };
      services = {
        haproxy = {
          enable = true;
          config = ''
            global
              log stderr format iso local7
            defaults
              mode tcp
              log global
              option tcplog
              maxconn 20000
              timeout client 200s
              timeout server 200s
              timeout connect 20s
            frontend minecraft-frontend
              bind *:25565
              tcp-request inspect-delay 5s
              acl craft req.payload(5,16),lower -m sub mc.lench.org
              tcp-request content accept if craft
              use_backend craft if craft
              acl other-craft req.payload(5,16),lower -m sub gtnh.lench.org
              tcp-request content accept if other-craft
              use_backend other-craft if other-craft
            backend craft
               server craft-server 0.0.0.0:25564 check
            backend other-craft
               server craft-server 192.168.1.4:25566 check
          '';
        };
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
