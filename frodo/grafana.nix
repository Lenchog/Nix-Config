{ config, ... }:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        enforce_domain = false;
        enable_gzip = true;
        domain = "grafana.lench.org";
      };

      # Prevents Grafana from phoning home
      analytics.reporting_enabled = false;
    };
  };
  services.prometheus = {
    enable = true;
    exporters = {
      node = {
        enable = true;
        port = 9000;
        enabledCollectors = [ "systemd" ];
        extraFlags = [
          "--collector.ethtool"
          "--collector.softirqs"
          "--collector.tcpstat"
        ];
      };
      nginx = {
        enable = false;
        port = 9001;
      };
      dnsmasq = {
        enable = true;
        port = 9002;
      };
      # restic = {
      #   enable = true;
      #   repository = "/var/restic";
      #   passwordFile = "${config.sops.secrets."resticPassword".path}";
      #   port = 9003;
      # };
      wireguard = {
        enable = true;
        port = 9004;
      };
    };
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [
              "localhost:${toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
      }
      {
        job_name = "minecraft";
        static_configs = [ { targets = [ "localhost:25585" ]; } ];
      }
      {
        job_name = "nginx";
        static_configs = [ { targets = [ "localhost:9001" ]; } ];
      }
      {
        job_name = "dnsmasq";
        static_configs = [ { targets = [ "localhost:9002" ]; } ];
      }
      {
        job_name = "restic";
        static_configs = [ { targets = [ "localhost:9003" ]; } ];
      }
      {
        job_name = "wireguard";
        static_configs = [ { targets = [ "localhost:9004" ]; } ];
      }
    ];
  };
}
