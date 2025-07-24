{
  config,
  pkgs,
  inputs,
  ...
}:
{
  networking = {
    hostName = "frodo";
    dhcpcd.enable = false;
    defaultGateway = "192.168.0.1";
    useDHCP = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443 # http
        53 # dnsmasq
        25565 # minecraft
      ];
      allowedUDPPorts = [
        53
        67 # blocky / dhcp
      ];
    };
    interfaces.eno1.ipv4.addresses = [
      {
        address = "192.168.0.42";
        prefixLength = 24;
      }
    ];
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "lennyescott@gmail.com";
    certs."lench.org" = {
      environmentFile = "${pkgs.writeText "desec-creds" ''
        DESEC_TOKEN_FILE=${config.sops.secrets."desec-token".path}
      ''}";
    };
  };
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts =
      let
        SSL = {
          enableACME = true;
          forceSSL = true;
        };
      in
      {
        "grafana.lench.org" = (
          SSL
          // {
            locations."/" = {
              proxyPass = "http://127.0.0.1:3000/";
              proxyWebsockets = true;
            };
          }
        );
        "photos.lench.org" = (
          SSL
          // {
            locations."/".proxyPass = "http://127.0.0.1:2342/";
          }
        );
        "search.lench.org" = (
          SSL
          // {
            locations."/".proxyPass = "http://127.0.0.1:8888/";
          }
        );
        "sync.lench.org" = (
          SSL
          // {
            locations."/".proxyPass = "http://127.0.0.1:8384/";
          }
        );
        "lench.org" = (
          SSL
          // {
            root = "${inputs.lenchorg}";
          }
        );
        "vault.lench.org" = (
          SSL
          // {
            locations."/" = {
              proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
              proxyWebsockets = true;
              extraConfig = ''
                								proxy_set_header Host $host;
                								proxy_set_header X-Real-IP $remote_addr;
                								proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                								proxy_set_header X-Forwarded-Proto $scheme;
                							'';
            };
          }
        );
      };
  };
  services.dnsmasq = {
    enable = true;
    settings = {
      dhcp-range = [ "192.168.0.2,192.168.0.254" ];
      dhcp-option = "option:router,192.168.0.1";
      dhcp-authoritative = true;
      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;
      server = [
        "127.0.0.1#5335"
        "1.1.1.1"
      ];
      local = "/lench.org/";
      address = "/lench.org/192.168.0.42";
    };
  };
}
