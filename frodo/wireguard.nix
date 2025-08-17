{ pkgs, config, ... }:
{
  systemd.services.wg-quick-wg0 = {
    after = [
      "network-online.target"
      "network.target"
      "systemd-networkd.service"
    ];
    wants = [ "network-online.target" ];
    partOf = [ "network.target" ];
  };
  networking.wg-quick.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP/IPv6 address and subnet of the client's end of the tunnel interface
      address = [
        "58.110.77.244"
      ];
      # The port that WireGuard listens to - recommended that this be changed from default
      listenPort = 4242;
      # Path to the server's private key
      privateKeyFile = config.sops.secrets."wireguard-frodo-private".path;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      postUp = ''
        ip route add 58.110.77.244/32 dev eno1
        ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.1/24 -o eno1 -j MASQUERADE
      '';

      # Undo the above
      preDown = ''
        ip route del 58.110.77.244/32 dev eno1
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.1/24 -o eno1 -j MASQUERADE
      '';

      peers = [
        {
          # peer0
          publicKey = "3EBeOolUQ9uBSUElwwG6k0NQyS6+LFLmOKDyC/fCm2U=";
          allowedIPs = [
            "0.0.0.0/5"
            "8.0.0.0/7"
            "11.0.0.0/8"
            "12.0.0.0/6"
            "128.0.0.0/1"
          ];
        }
        # More peers can be added here.
      ];
    };
  };
}
