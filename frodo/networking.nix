{ config, pkgs, ... }:
{
  networking = {
    hostName = "frodo";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        # http
        80
        443
        # blocky
        53
        23
        # minecraft
        25565
        25564
        # photoprism
        2342
				# grafana
				3000
      ];
      allowedUDPPorts = [
        51820
        53
        # minecraft voice chat
        24454
      ];
    };
    interfaces.wlp3s0.ipv4.addresses = [
      {
        address = "192.168.0.154";
        prefixLength = 24;
      }
    ];
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "lennyescott@gmail.com";
    certs."lench.org" = {
      dnsProvider = "desec";
			webroot = null;
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
				"vault.lench.org" = (
					SSL
					// {
						extraConfig = ''
							access_log /var/log/nginx/vault.lench.org.access.log;
							error_log /var/log/nginx/vault.lench.org.error.log
						'';
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
        /* "lench.org" = (
          SSL
          // {
            locations."/" = {
							index = "test.html";
							root = ".";
						};
          }
        ); */
      };
  };
}
