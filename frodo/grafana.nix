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
    exporters.node = {
      enable = true;
      port = 9000;
      enabledCollectors = [ "systemd" ];
      extraFlags = [
        "--collector.ethtool"
        "--collector.softirqs"
        "--collector.tcpstat"
      ];
    };
    scrapeConfigs = [
      {
        job_name = "prometheus";
        static_configs = [
          {
            targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
          }
        ];
      }
      {
        job_name = "minecraft";
        static_configs = [
          {
            targets = [ "localhost:25585" ];
          }
        ];
      }
    ];
  };
}
