{
  inputs,
  self,
  ...
}:
{
  flake = {
    nixosConfigurations.sam = inputs.nixpkgs.lib.nixosSystem {
      modules = with self.modules.nixos; [
        base
        fileSystems
        sops
        kanata
        legolas
        boot
        networking
        nix-conf
        users
        sam
        homeManagerServer
        minecraft
      ];
    };
    modules.nixos.sam = {
      networking = {
        firewall = {
          enable = true;
          interfaces.wlp0s20f3 = {
            allowedTCPPorts = [
              25565 # minecraft
              25566 # minecraft
              25564 # also minecraft idk why we need this
              2121 # ssh
            ];
          };
        };
        interfaces.wlp0s20f3.ipv4.addresses = [
          {
            address = "192.168.1.67";
            prefixLength = 24;
          }
        ];
      };
      services = {
        # Enable automatic login for the user.
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "lenny";

        minecraft-servers.servers.gtnh.enable = true;
        logind.lidSwitchExternalPower = "ignore";
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

    networking.hostname = "sam";
    boot.kernelModules = [ "kvm-intel" ];
    hardware.cpu.intel.updateMicrocode = true;
  };
}
