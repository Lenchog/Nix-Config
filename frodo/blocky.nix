{ ... }:
{
  services.blocky = {
    enable = true;
    settings = {
      ports = {
        dns = 5335;
        https = 4000;
      }; # Port for incoming DNS Queries.
      upstream.default = [
        "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
      ];

      # For initially solving DoH/DoT Requests when no system Resolver is available.

      /*
        bootstrap.Dns = {
        	upstream = "https://one.one.one.one/dns-query";
        	ips = [ "1.1.1.1" "1.0.0.1" ];
        };
      */

      #Enable Blocking of certian domains.
      blocking = {
        blackLists = {
          #Adblocking
          ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
          #You can add additional categories
        };
        #Configure what block categories are used
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
    };
  };
}
