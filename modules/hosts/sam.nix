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
      systemd.sleep.extraConfig = ''
        AllowSuspend=no
        AllowHibernation=no
        AllowHybridSleep=no
        AllowSuspendThenHibernate=no
      '';
      services = {
        # Enable automatic login for the user.
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "eric";

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

        haproxy.config = ''
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
            bind *:25564
            tcp-request inspect-delay 5s
            acl craft req.payload(5,16),lower -m sub gtnh.lench.org
            tcp-request content accept if craft
            use_backend craft if craft
          backend craft
             server craft-server 127.0.0.1:25564 check
        '';
      };
    };

    networking.hostname = "sam";
    boot.kernelModules = [ "kvm-intel" ];
    hardware.cpu.intel.updateMicrocode = true;
  };
}
