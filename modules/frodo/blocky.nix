{
  flake.modules.nixos.blocky.services.blocky = {
    enable = true;
    settings = {
      ports = {
        dns = 53;
        https = 4000;
      }; # Port for incoming DNS Queries.
      upstream.default = [
        "1.1.1.1" # Cloudflare (IP)
        "8.8.8.8" # Google (IP)
      ];

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
