{
  config,
  pkgs,
  inputs,
  ...
}:
{
  networking = {
    hostName = "frodo";
    defaultGateway = "192.168.1.1";
    firewall = {
      enable = true;
      interfaces."eno1" = {
        allowedTCPPorts = [
          80 # http
          443 # https
          25565 # minecraft
          25564 # also minecraft idk why we need this
          2121 # ssh
        ];
        allowedUDPPorts = [
          53
          67 # blocky / dhcp
        ];
      };
      interfaces."wg0".allowedUDPPorts = [ 4242 ];
    };
    interfaces.eno1.ipv4.addresses = [
      {
        address = "192.168.1.42";
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
            locations."/" = {
              proxyPass = "http://[::1]:${toString config.services.immich.port}";
              proxyWebsockets = true;
            };
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
        "jellyfin.lench.org" = (
          SSL
          // {
            locations."/".proxyPass = "http://127.0.0.1:8096/";
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
}
