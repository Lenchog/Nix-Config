{ inputs, self, ... }:
{
  flake.nixosConfigurations.frodo = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.frodo
      self.modules.nixos.main
      self.modules.nixos.gui
    ];
  };
  flake.modules.nixos.frodo = {
    jellyfin.enable = true;
    openssh = {
      enable = true;
      ports = [ 2121 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    fail2ban.enable = true;
    networking.hostname = "frodo";
    sops.secrets = {
      garf_key = { };
      wireguard-frodo-private = { };
      resticPassword = { };
      # desec-token = {
      #   owner = config.users.users.acme.name;
      # };
      photoprism-password = { };
    };
  };
}
