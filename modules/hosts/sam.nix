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
      services.minecraft-servers.servers.gtnh.enable = true;
      services.logind.lidSwitchExternalPower = "ignore";
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
    services.haproxy.config = ''
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
        acl craft req.payload(5,16),lower -m sub gtnh.lench.org
        tcp-request content accept if craft
        use_backend craft if craft
      backend craft
         server craft-server 127.0.0.1:25564 check
    '';
    networking.hostname = "sam";
    boot.kernelModules = [ "kvm-intel" ];
    hardware.cpu.intel.updateMicrocode = true;
  };
}
